Class {
	#name : #Gt2InspectorModel,
	#superclass : #Gt2InspectorProtoModel,
	#traits : 'TGt2InspectorObjectHolderAccess + TGt2InspectorExtensionsAccess',
	#classTraits : 'TGt2InspectorObjectHolderAccess classTrait + TGt2InspectorExtensionsAccess classTrait',
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
	self initializeExtensions.
]

{ #category : #notifying }
Gt2InspectorModel >> notifyObjectChangedTo: anObject [
	self extensions objectChangedTo: anObject.
]

{ #category : #notifying }
Gt2InspectorModel >> notifyObjectHolderChanged [
	self objectHolder notifyObjectChangedIn: self. 
]

{ #category : #notifying }
Gt2InspectorModel >> notifyObjectRemoved [
	self extensions objectRemoved.
]

{ #category : #convenience }
Gt2InspectorModel >> object [
	^ self objectHolder object
]
