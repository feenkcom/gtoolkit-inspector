Class {
	#name : #GtPager,
	#superclass : #BrPager,
	#instVars : [
		'context'
	],
	#category : #'GToolkit-Pager-UI'
}

{ #category : #'instance creation' }
GtPager class >> createOn: anElement [
	| aPager theElement |
	theElement := anElement asElement.
	self 
		assert: [ theElement viewModel isKindOf: BrPagerPageModel ] 
		description: [ 'The tool element must have ', BrPagerPageModel name asString, ' view model' ].
	aPager := self new.
	aPager 
		matchParent;
		addPage: theElement.
	^ aPager
]

{ #category : #defaults }
GtPager class >> defaultExtent [
	^ 1200@600
]

{ #category : #'private - instance creation' }
GtPager class >> newSpaceWith: anElement title: aTitle [
	| aSpace |
	aSpace := BlSpace new.
	aSpace withHalos.
	aSpace title: aTitle asString.
	aSpace extent: self defaultExtent.
	aSpace root addChild: anElement.
	^ aSpace
]

{ #category : #'instance creation' }
GtPager class >> openOn: anElement [
	^ self openOn: anElement title: 'GToolkit'
]

{ #category : #'instance creation' }
GtPager class >> openOn: anElement title: aTitle [
	| aPager |
	aPager :=  self createOn: anElement.
	self openSpaceWith: aPager title: aTitle.
	^ aPager
]

{ #category : #'instance creation' }
GtPager class >> openOn: anElement title: aTitle from: aSourceElement [
	| aPager |
	aPager :=  self createOn: anElement.
	self openSpaceWith: aPager title: aTitle from: aSourceElement.
	^ aPager
]

{ #category : #'private - instance creation' }
GtPager class >> openSpaceWith: anElement title: aTitle [
	| aSpace |
	aSpace := self newSpaceWith: anElement title: aTitle.
	aSpace show.
	^ aSpace
]

{ #category : #'private - instance creation' }
GtPager class >> openSpaceWith: anElement title: aTitle from: aSourceElement [
	| aSpace |
	aSpace := self newSpaceWith: anElement title: aTitle.
	aSourceElement showSpace: aSpace.
	^ aSpace
]

{ #category : #asserting }
GtPager >> assertToolElement: aToolElement [
	self 
		assert: [ aToolElement isKindOf: BlElement ] 
		description: [ 'Tool element must be kind of ', BlElement name ].
	self 
		assert: [ aToolElement viewModel isKindOf: BrPagerPageModel ] 
		description: [ 'Tool element view model must be kind of ', BrPagerPageModel name ].
	
]

{ #category : #accessing }
GtPager >> context [
	<return: #GtPagerContext>
	^ context
]

{ #category : #defaults }
GtPager >> defaultContext [
	^ GtPagerContext new
]

{ #category : #initialization }
GtPager >> initialize [
	super initialize.
	context := self defaultContext.
]

{ #category : #'api - requests' }
GtPager >> maximizePageContentIn: anElement [
	GtPagerEventPassingMaximizer new 
		pager: self;
		contentElement: anElement;
		maximize
]

{ #category : #'instance creation' }
GtPager >> newPagerModel [
	^ GtPagerModel new
]

{ #category : #'api - scrolling' }
GtPager >> select: aGtPagerPageSelectionContext [
	self assertToolElement: aGtPagerPageSelectionContext afterPage.
	(self hasPageAfter: aGtPagerPageSelectionContext afterPage) ifTrue: [
		self spawn: aGtPagerPageSelectionContext ]
]

{ #category : #'api - scrolling' }
GtPager >> spawn: aGtPagerPageSelectionContext [
	aGtPagerPageSelectionContext asElementDo: [ :aToolElement | 
		self assertToolElement: aToolElement.
		self assertToolElement: aGtPagerPageSelectionContext afterPage.
		self removePagesAfter: aGtPagerPageSelectionContext afterPage.
		self addPage: aToolElement.
		self smoothScrollToLast
	] 
]
