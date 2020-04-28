Class {
	#name : #Gt2Inspector,
	#superclass : #BlElement,
	#instVars : [
		'model'
	],
	#category : #'GToolkit-Inspector-! New - UI'
}

{ #category : #'instance creation' }
Gt2Inspector class >> createOn: anObject [
	| aWrapper |
	aWrapper := self newWrapperOn: anObject.
	^ GtPager createOn: aWrapper.
]

{ #category : #'private - instance creation' }
Gt2Inspector class >> newEmbelisher [
	^ GtPagerPageEmbellisher new
]

{ #category : #'instance creation' }
Gt2Inspector class >> newOn: anObject [
	"create an inspector element on a given object"
	^ self new 
		object: anObject;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].
]

{ #category : #'instance creation' }
Gt2Inspector class >> newTitleFrom: anObject [
	^ 'Inspector on ' , anObject printString
]

{ #category : #'private - instance creation' }
Gt2Inspector class >> newWrapperOn: anObject [
	^ GtPagerPageWrapperStencil new
		stencil: [ self newOn: anObject ];
		model: anObject;
		embellisher: self newEmbelisher;
		asElement
]

{ #category : #'instance creation' }
Gt2Inspector class >> openOn: anObject [
	| anInspector |
	anInspector := self newWrapperOn: anObject.
	^ GtPager 
		openOn: anInspector 
		title: (self newTitleFrom: anObject)
]

{ #category : #'instance creation' }
Gt2Inspector class >> openOn: anObject from: aSourceElement [
	| anInspector |
	anInspector :=  self newOn: anObject.
	^ GtPager 
		openOn: anInspector 
		title: (self newTitleFrom: anObject)
		from: aSourceElement.
]

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
