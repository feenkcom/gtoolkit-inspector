Class {
	#name : #Gt2Inspector,
	#superclass : #BlElement,
	#category : #'GToolkit-Inspector-! New - UI'
}

{ #category : #accessing }
Gt2Inspector class >> default [
	^ self new look: Gt2InspectorLook
]

{ #category : #defaults }
Gt2Inspector >> defaultViewModel [
	^ Gt2InspectorModel new
]

{ #category : #initialization }
Gt2Inspector >> initialize [
	super initialize.
	self viewModel: self defaultViewModel
]

{ #category : #convenience }
Gt2Inspector >> object: anObject [
	| anObjectHolder |
	anObjectHolder := Gt2InspectorObjectHolder new object: anObject.
	self viewModel objectHolder: anObjectHolder.
]
