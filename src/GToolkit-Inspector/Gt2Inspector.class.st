Class {
	#name : #Gt2Inspector,
	#superclass : #BlElement,
	#instVars : [
		'model'
	],
	#category : #'GToolkit-Inspector-! New - UI'
}

{ #category : #private }
Gt2Inspector >> defaultModel [
	^ Gt2InspectorModel new
]

{ #category : #initialization }
Gt2Inspector >> initialize [
	super initialize.
	self initializeModel.
	self initializeWidget.
]

{ #category : #initialization }
Gt2Inspector >> initializeModel [
	model := self defaultModel
]

{ #category : #initialization }
Gt2Inspector >> initializeWidget [
	self updateView.
]

{ #category : #accessing }
Gt2Inspector >> model [
	<return: #Gt2InspectorModel>
	^ model
]

{ #category : #accessing }
Gt2Inspector >> model: aGtInspectorModel [
	self 
		assert: [ aGtInspectorModel isNotNil ] 
		description: [ 'Inspector model must be non-nil' ].
	aGtInspectorModel = self model ifTrue: [ ^ self ].
	model := aGtInspectorModel.
	self updateView.
]

{ #category : #convenience }
Gt2Inspector >> object: anObject [
	| anObjectHolder |
	anObjectHolder := Gt2InspectorObjectHolder new object: anObject.
	self model objectHolder: anObjectHolder.
	self updateView.
]

{ #category : #'updating ui' }
Gt2Inspector >> updateContentWith: aContentElement [
	"Create and configure an inspector page for a given object and corresponding content element.
	My job is to set up the pager page decorator and configure the neccesary event listeners"

	self 
		removeChildren;
		addChild: aContentElement
]

{ #category : #'updating ui' }
Gt2Inspector >> updateView [
	self model asElementDo: [ :aPageContentElement |
		self updateContentWith: aPageContentElement ]
]
