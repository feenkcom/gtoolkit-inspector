Class {
	#name : #Gt2InspectorObjectHolder,
	#superclass : #Gt2InspectorProtoObjectHolder,
	#instVars : [
		'object',
		'hasObject'
	],
	#category : #'GToolkit-Inspector-! New - Model'
}

{ #category : #factory }
Gt2InspectorObjectHolder class >> null [ 
	^ Gt2InspectorNullObjectHolder default
]

{ #category : #converting }
Gt2InspectorObjectHolder >> asElementDo: aOneArgBlock [
	"Create an element representing an object and execute the block"
	self view asElementDo: aOneArgBlock
]

{ #category : #asserting }
Gt2InspectorObjectHolder >> assertImmutability [
	self 
		assert: [ hasObject not ]
		description: [ 'Object holder is immutable.' ].
]

{ #category : #initialization }
Gt2InspectorObjectHolder >> initialize [
	super initialize.
	hasObject := false.
]

{ #category : #notifying }
Gt2InspectorObjectHolder >> notifyObjectChangedIn: aModel [
	aModel notifyObjectChangedTo: self object.
]

{ #category : #accessing }
Gt2InspectorObjectHolder >> object [
	^ object
]

{ #category : #accessing }
Gt2InspectorObjectHolder >> object: anObject [
	self assertImmutability.
	object := anObject.
	hasObject := true.
]

{ #category : #printing }
Gt2InspectorObjectHolder >> printOn: aStream [
	aStream 
		nextPutAll: 'Holder of ';
		print: self object
]

{ #category : #accessing }
Gt2InspectorObjectHolder >> view [
	<return: #GtPhlowLabelledView>
	^ self object gtViewsFor: GtPhlowView empty
]
