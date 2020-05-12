Class {
	#name : #Gt2Inspector,
	#superclass : #BlElement,
	#traits : 'TGtPagerWindowOpener',
	#classTraits : 'TGtPagerWindowOpener classTrait',
	#instVars : [
		'model'
	],
	#category : #'GToolkit-Inspector-! New - UI'
}

{ #category : #'private - instance creation' }
Gt2Inspector class >> newEmbelisher [
	^ Gt2InspectorEmbellisher new
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

{ #category : #'private - instance creation' }
Gt2Inspector class >> newTitleFrom: anObject [
	^ 'Inspector on ' , anObject printString
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
	self initializeListeners.
]

{ #category : #initialization }
Gt2Inspector >> initializeListeners [
	self when: GtPagerPageAddedEvent do: [ :anEvent | 
		self onAddedToPager: anEvent pager ].
	self when: GtPagerPageRemovedEvent do: [ :anEvent | 
		self onRemovedFromPager: anEvent pager ].
	self when: GtPagerPageMaximizedEvent do: [ :anEvent | 
		self onMaximizedInPager: anEvent pager ].
	self when: GtPagerPageMinimizedEvent do: [ :anEvent | 
		self onMinimizedInPager: anEvent pager ].
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
Gt2Inspector >> object [
	self model object
]

{ #category : #convenience }
Gt2Inspector >> object: anObject [
	| anObjectHolder |
	anObjectHolder := Gt2InspectorObjectHolder new object: anObject.
	self model objectHolder: anObjectHolder.
	self updateView.
]

{ #category : #hooks }
Gt2Inspector >> onAddedToPager: aGtPager [
	"Inspector was added to a pager"
	self phlow
		firstChildWithCompositeViewDo: [ :aTabGroup | 
			aGtPager context inspectorTabSelector
				selectTabIn: aTabGroup on: self object ].
]

{ #category : #hooks }
Gt2Inspector >> onMaximizedInPager: aGtPager [
	"Inspector was maximized int the pager"
]

{ #category : #hooks }
Gt2Inspector >> onMinimizedInPager: aGtPager [
	"Inspector was minimized int the pager"
]

{ #category : #hooks }
Gt2Inspector >> onRemovedFromPager: aGtPager [
	"Inspector was removed from a pager"
	| aInspectorTabName |
	aInspectorTabName := Gt2InspectorSelectedTabExtractor new 
		inspectorElement: self;
		extract.
	aGtPager context inspectorTabSelector recentlySelectedTab: aInspectorTabName on: self object.
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
