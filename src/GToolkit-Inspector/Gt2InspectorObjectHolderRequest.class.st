Class {
	#name : #Gt2InspectorObjectHolderRequest,
	#superclass : #BrRequest,
	#category : #'GToolkit-Inspector-! New - Events'
}

{ #category : #initialization }
Gt2InspectorObjectHolderRequest >> responseClass [
	^ Gt2InspectorObjectHolderChanged
]
