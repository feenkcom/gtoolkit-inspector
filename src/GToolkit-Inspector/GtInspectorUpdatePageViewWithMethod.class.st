Class {
	#name : #GtInspectorUpdatePageViewWithMethod,
	#superclass : #GtInspectorTask,
	#instVars : [
		'compiledMethod',
		'affectedClass'
	],
	#category : #'GToolkit-Inspector-Utility'
}

{ #category : #comparing }
GtInspectorUpdatePageViewWithMethod >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ affectedClass = anObject affectedClass
		and: [ self selector = anObject selector
				and: [ inspectorInstance = anObject inspectorInstance ] ]
]

{ #category : #accessing }
GtInspectorUpdatePageViewWithMethod >> affectedClass [
	^ affectedClass
]

{ #category : #accessing }
GtInspectorUpdatePageViewWithMethod >> affectedClass: anObject [
	affectedClass := anObject
]

{ #category : #accessing }
GtInspectorUpdatePageViewWithMethod >> compiledMethod [
	^ compiledMethod
]

{ #category : #accessing }
GtInspectorUpdatePageViewWithMethod >> compiledMethod: anObject [
	compiledMethod := anObject
]

{ #category : #execution }
GtInspectorUpdatePageViewWithMethod >> execute [
	inspectorInstance pager pages do: [ :eachPage | 
		(self doesPage: eachPage displayClass: self affectedClass) ifTrue: [ 
			GtInspectorPageViewUpdater new
				inspectorWidget: inspectorInstance;
				pagerPageModel: eachPage;
				viewMethodDefinition: self compiledMethod asRingDefinition;
				update ] ]
]

{ #category : #comparing }
GtInspectorUpdatePageViewWithMethod >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ affectedClass hash
		bitXor: (self selector hash bitXor: inspectorInstance hash)
]

{ #category : #accessing }
GtInspectorUpdatePageViewWithMethod >> selector [
	^ self compiledMethod ifNotNil: #selector
]
