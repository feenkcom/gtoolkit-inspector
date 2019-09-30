Class {
	#name : #GtInspectorUpdatePagesWithClassTask,
	#superclass : #GtInspectorTask,
	#instVars : [
		'affectedClass'
	],
	#category : #'GToolkit-Inspector-Utility'
}

{ #category : #comparing }
GtInspectorUpdatePagesWithClassTask >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ inspectorInstance = anObject inspectorInstance
		and: [ affectedClass = anObject affectedClass ]
]

{ #category : #accessing }
GtInspectorUpdatePagesWithClassTask >> affectedClass [
	^ affectedClass
]

{ #category : #accessing }
GtInspectorUpdatePagesWithClassTask >> affectedClass: anObject [
	affectedClass := anObject
]

{ #category : #execution }
GtInspectorUpdatePagesWithClassTask >> execute [
	inspectorInstance pager pages do: [ :eachPage | 
		(self doesPage: eachPage displayClass: self affectedClass) 
			ifTrue: [ inspectorInstance enqueueTask: (
				BlTaskAction new action: [ inspectorInstance updatePageModelWidget: eachPage ]) ] ]
]

{ #category : #comparing }
GtInspectorUpdatePagesWithClassTask >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ inspectorInstance hash bitXor: affectedClass hash
]

{ #category : #printing }
GtInspectorUpdatePagesWithClassTask >> printOn: aStream [
	aStream
		nextPutAll: 'Inspetor update with class: ';
		print: affectedClass
]
