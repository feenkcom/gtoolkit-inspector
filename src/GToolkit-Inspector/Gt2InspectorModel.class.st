Class {
	#name : #Gt2InspectorModel,
	#superclass : #BrWidgetModel,
	#traits : 'TGt2InspectorObjectHolderAccess',
	#classTraits : 'TGt2InspectorObjectHolderAccess classTrait',
	#category : #'GToolkit-Inspector-! New - Model'
}

{ #category : #initialization }
Gt2InspectorModel >> initialize [
	super initialize.
	self initializeObjectHolder.
]

{ #category : #initialization }
Gt2InspectorModel >> initializeListeners [
	super initializeListeners.
	self 
		when: Gt2InspectorObjectHolderRequest 
		reply: [ :aResponse | aResponse objectHolder: self objectHolder ]
]

{ #category : #notifying }
Gt2InspectorModel >> notifyObjectHolderChanged [
	self dispatchEvent: (Gt2InspectorObjectHolderChanged new objectHolder: self objectHolder)
]
