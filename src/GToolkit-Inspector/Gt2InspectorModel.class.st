Class {
	#name : #Gt2InspectorModel,
	#superclass : #Gt2InspectorProtoModel,
	#traits : 'TGt2InspectorObjectHolderAccess',
	#classTraits : 'TGt2InspectorObjectHolderAccess classTrait',
	#instVars : [
		'viewSelector'
	],
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

{ #category : #defaults }
Gt2InspectorModel >> defaultViewSelector [
	^ Gt2InspectorViewSelector last
]

{ #category : #initialization }
Gt2InspectorModel >> initialize [
	super initialize.
	self initializeObjectHolder.
	self initializeViewSelector.
]

{ #category : #initialization }
Gt2InspectorModel >> initializeViewSelector [
	viewSelector := self defaultViewSelector.
]
