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

{ #category : #testing }
GtInspectorTabSelector class >> isDeprecated [
	"Use GtPhlowTabSelector subclasses instead."

	^ true
]

{ #category : #actions }
GtInspectorTabSelector >> matchesTab: aTabGroup [ 
	self subclassResponsibility
]

{ #category : #actions }
GtInspectorTabSelector >> selectTabInGroup: aTabGroupElement on: anObject [
	<return: #GtPhlowToolSelectionStateResponse>
	^ aTabGroupElement viewModel tabs
		detect: [ :aTabModel | 
			self matchesTab: aTabModel ]
		ifFound: [ :aTabModel |
			| aSignal |
			aSignal := GtPhlowSelectTabSignal new
				tabGroup: aTabGroupElement;
				requestedTabModel: aTabModel;
				selector: self;
				emit.
			
		 	aTabModel select.
		 	
		 	aTabGroupElement viewModel selectedTabDo: [ :aTab |
		 		aSignal selectedTabModel: aTabModel ].
		 		
		 	GtPhlowToolSelectionStateResponse applied ]
		ifNone: [ GtPhlowToolSelectionStateResponse notApplied ]
]

{ #category : #actions }
GtInspectorTabSelector >> selectTabInInspectorElement: anInspectorElement on: anObject [
	<return: #GtPhlowToolSelectionStateResponse>
	anInspectorElement phlow
		firstChildWithCompositeViewContentDo: [ :aTabGroupElement | 
			^ self selectTabInGroup: aTabGroupElement on: anObject ].
			
	^ GtPhlowToolSelectionStateResponse notApplied
]
