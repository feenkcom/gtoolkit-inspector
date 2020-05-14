Class {
	#name : #GtInspectorObject,
	#superclass : #GtInspectorAbstractObject,
	#instVars : [
		'object',
		'hasObject'
	],
	#category : #'GToolkit-Inspector-! New - Model'
}

{ #category : #factory }
GtInspectorObject class >> null [ 
	^ GtInspectorNullObject default
]

{ #category : #converting }
GtInspectorObject >> asElementDo: aOneArgBlock [
	"Create an element representing an object and execute the block"
	self view asElementDo: aOneArgBlock
]

{ #category : #asserting }
GtInspectorObject >> assertImmutability [
	self 
		assert: [ hasObject not ]
		description: [ 'Object holder is immutable.' ].
]

{ #category : #initialization }
GtInspectorObject >> initialize [
	super initialize.
	hasObject := false.
]

{ #category : #notifying }
GtInspectorObject >> notifyObjectChangedIn: anInspector [
	anInspector notifyObjectChangedTo: self object.
]

{ #category : #accessing }
GtInspectorObject >> object [
	^ object
]

{ #category : #accessing }
GtInspectorObject >> object: anObject [
	self assertImmutability.
	object := anObject.
	hasObject := true.
]

{ #category : #printing }
GtInspectorObject >> printOn: aStream [
	aStream 
		nextPutAll: 'Holder of ';
		print: self object
]

{ #category : #accessing }
GtInspectorObject >> view [
	<return: #GtPhlowLabelledView>
	^ self object gtViewsFor: GtPhlowView empty
]
