Class {
	#name : #Gt2InspectorObjectHolderChanged,
	#superclass : #BrChangeEvent,
	#traits : 'TGt2InspectorObjectHolderAccess',
	#classTraits : 'TGt2InspectorObjectHolderAccess classTrait',
	#category : #'GToolkit-Inspector-! New - Events'
}

{ #category : #initialization }
Gt2InspectorObjectHolderChanged >> initialize [ 
	super initialize.
	self initializeObjectHolder.
]
