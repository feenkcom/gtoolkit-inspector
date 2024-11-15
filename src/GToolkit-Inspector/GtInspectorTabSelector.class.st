Class {
	#name : #GtInspectorTabSelector,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Inspector-Tab Selector'
}

{ #category : #factory }
GtInspectorTabSelector class >> byViewMethod [
	^ GtInspectorTabByViewMethodSelector new
]

{ #category : #factory }
GtInspectorTabSelector class >> byViewName [
	^ GtInspectorTabByViewNameSelector new
]

{ #category : #testing }
GtInspectorTabSelector class >> isAbstract [
	^ self name = #GtInspectorTabSelector 
]

{ #category : #actions }
GtInspectorTabSelector >> matchesTab: aTabGroup [ 
	self subclassResponsibility
]

{ #category : #actions }
GtInspectorTabSelector >> selectTabInGroup: aTabGroupElement on: anObject [
	aTabGroupElement viewModel tabs
		detect: [ :aTabModel | 
			self matchesTab: aTabModel ]
		ifFound: [ :aTabModel |
			| aSignal |
			aSignal := GtInspectorSelectTabSignal new
				tabGroup: aTabGroupElement;
				requestedTabModel: aTabModel;
				selector: self;
				emit.
			
		 	aTabModel select.
		 	
		 	aTabGroupElement viewModel selectedTabDo: [ :aTab |
		 		aSignal selectedTabModel: aTabModel ] ]
		ifNone: [ "do nothing" ]
]

{ #category : #actions }
GtInspectorTabSelector >> selectTabInInspectorElement: anInspectorElement on: anObject [
	anInspectorElement phlow firstChildWithCompositeViewContentDo: [ :aTabGroupElement | 
		self selectTabInGroup: aTabGroupElement on: anObject ]
]
