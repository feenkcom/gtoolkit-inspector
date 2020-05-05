Class {
	#name : #Gt2InspectorModel,
	#superclass : #Gt2InspectorProtoModel,
	#traits : 'TGt2InspectorObjectHolderAccess',
	#classTraits : 'TGt2InspectorObjectHolderAccess classTrait',
	#category : #'GToolkit-Inspector-! New - Model'
}

{ #category : #factory }
Gt2InspectorModel class >> null [ 
	^ Gt2InspectorNullModel default
]

{ #category : #converting }
Gt2InspectorModel >> asElementDo: aOneArgBlock [
	"Create an element representing an object and execute the block"
	self objectHolder asElementDo: aOneArgBlock
]

{ #category : #initialization }
Gt2InspectorModel >> initialize [
	super initialize.
	self initializeObjectHolder.
]

{ #category : #convenience }
Gt2InspectorModel >> object [
	^ self objectHolder object
]
