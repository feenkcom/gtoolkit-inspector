Class {
	#name : #GtInspector,
	#superclass : #BlElement,
	#traits : 'TGtPagerWindowOpener',
	#classTraits : 'TGtPagerWindowOpener classTrait',
	#instVars : [
		'model'
	],
	#category : #'GToolkit-Inspector-! New - UI'
}

{ #category : #'private - instance creation' }
GtInspector class >> newEmbelisher [
	^ Gt2InspectorEmbellisher new
]

{ #category : #'instance creation' }
GtInspector class >> newOn: anObject [
	"create an inspector element on a given object"
	^ self new 
		object: anObject;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].
]

{ #category : #'private - instance creation' }
GtInspector class >> newTitleFrom: anObject [
	^ 'Inspector on ' , anObject printString
]

{ #category : #private }
GtInspector >> defaultModel [
	^ Gt2InspectorModel new
]

{ #category : #initialization }
GtInspector >> initialize [
	super initialize.
	self initializeModel.
	self initializeWidget.
	self initializeListeners.
]

{ #category : #initialization }
GtInspector >> initializeListeners [
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
GtInspector >> initializeModel [
	model := self defaultModel
]

{ #category : #initialization }
GtInspector >> initializeWidget [
	self updateView.
]

{ #category : #accessing }
GtInspector >> model [
	<return: #Gt2InspectorModel>
	^ model
]

{ #category : #accessing }
GtInspector >> model: aGtInspectorModel [
	self 
		assert: [ aGtInspectorModel isNotNil ] 
		description: [ 'Inspector model must be non-nil' ].
	aGtInspectorModel = self model ifTrue: [ ^ self ].
	model := aGtInspectorModel.
	self updateView.
]

{ #category : #convenience }
GtInspector >> object [
	self model object
]

{ #category : #convenience }
GtInspector >> object: anObject [
	| anObjectHolder |
	anObjectHolder := Gt2InspectorObjectHolder new object: anObject.
	self model objectHolder: anObjectHolder.
	self updateView.
]

{ #category : #hooks }
GtInspector >> onAddedToPager: aGtPager [
	"Inspector was added to a pager"
	self phlow
		firstChildWithCompositeViewDo: [ :aTabGroup | 
			aGtPager context inspectorTabSelector
				selectTabIn: aTabGroup on: self object ].
]

{ #category : #hooks }
GtInspector >> onMaximizedInPager: aGtPager [
	"Inspector was maximized int the pager"
]

{ #category : #hooks }
GtInspector >> onMinimizedInPager: aGtPager [
	"Inspector was minimized int the pager"
]

{ #category : #hooks }
GtInspector >> onRemovedFromPager: aGtPager [
	"Inspector was removed from a pager"
	| aInspectorTabName |
	aInspectorTabName := Gt2InspectorSelectedTabExtractor new 
		inspectorElement: self;
		extract.
	aGtPager context inspectorTabSelector recentlySelectedTab: aInspectorTabName on: self object.
]

{ #category : #'updating ui' }
GtInspector >> updateContentWith: aContentElement [
	"Create and configure an inspector page for a given object and corresponding content element.
	My job is to set up the pager page decorator and configure the neccesary event listeners"

	self 
		removeChildren;
		addChild: aContentElement
]

{ #category : #'updating ui' }
GtInspector >> updateView [
	self model asElementDo: [ :aPageContentElement |
		self updateContentWith: aPageContentElement ]
]
