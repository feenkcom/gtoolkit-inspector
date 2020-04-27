Class {
	#name : #Gt2InspectorObjectHolder,
	#superclass : #Gt2InspectorProtoObjectHolder,
	#instVars : [
		'object'
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

{ #category : #accessing }
Gt2InspectorObjectHolder >> object [
	^ object
]

{ #category : #accessing }
Gt2InspectorObjectHolder >> object: anObject [
	object := anObject
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
