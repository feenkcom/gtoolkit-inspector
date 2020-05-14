Class {
	#name : #GtInspectorRemovePageViewWithMethod,
	#superclass : #GtOldInspectorTask,
	#instVars : [
		'compiledMethod',
		'affectedClass'
	],
	#category : #'GToolkit-Inspector-Utility'
}

{ #category : #comparing }
GtInspectorRemovePageViewWithMethod >> = anObject [
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
GtInspectorRemovePageViewWithMethod >> affectedClass [
	^ affectedClass
]

{ #category : #accessing }
GtInspectorRemovePageViewWithMethod >> affectedClass: anObject [
	affectedClass := anObject
]

{ #category : #accessing }
GtInspectorRemovePageViewWithMethod >> compiledMethod [
	^ compiledMethod
]

{ #category : #accessing }
GtInspectorRemovePageViewWithMethod >> compiledMethod: anObject [
	compiledMethod := anObject
]

{ #category : #execution }
GtInspectorRemovePageViewWithMethod >> execute [
	inspectorInstance pager pages do: [ :eachPage | 
		(self doesPage: eachPage displayClass: self affectedClass) ifTrue: [ 
			GtOldInspectorPageViewUpdater new
				inspectorWidget: inspectorInstance;
				pagerPageModel: eachPage;
				viewMethodDefinition: self compiledMethod asRingDefinition;
				remove ] ]
]

{ #category : #comparing }
GtInspectorRemovePageViewWithMethod >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ affectedClass hash
		bitXor: (self selector hash bitXor: inspectorInstance hash)
]

{ #category : #accessing }
GtInspectorRemovePageViewWithMethod >> selector [
	^ self compiledMethod ifNotNil: #selector
]
