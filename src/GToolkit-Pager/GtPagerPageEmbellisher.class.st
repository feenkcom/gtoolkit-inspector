Class {
	#name : #GtPagerPageEmbellisher,
	#superclass : #BrPagerPageEmbellisher,
	#traits : 'TGtPagerSelectionContextAccessor + TGtPagerHolderAccessors',
	#classTraits : 'TGtPagerSelectionContextAccessor classTrait + TGtPagerHolderAccessors classTrait',
	#instVars : [
		'pageWidth'
	],
	#category : #'GToolkit-Pager-Stencils'
}

{ #category : #'widget configuration' }
GtPagerPageEmbellisher >> addNextPageButtonInto: aContentWrapper [
	| aTriangleElement |
	aTriangleElement := self newNextPageButton.
	aContentWrapper addChild: aTriangleElement.
	aContentWrapper
		when: GtPhlowObjectToSelect
		do: [ :anEvent | 
			aTriangleElement visibility: BlVisibility visible.
			self pagerHolder select: (self createSelectionContextFromEvent: anEvent) ].
	aContentWrapper
		when: GtPhlowObjectToSpawn
		do: [ :anEvent | 
			aTriangleElement visibility: BlVisibility visible.
			self pagerHolder spawn: (self createSelectionContextFromEvent: anEvent). ].
]

{ #category : #'api - instantiation' }
GtPagerPageEmbellisher >> create [
	<return: #BlElement>
	| aPageElement |
	aPageElement := self newPageElement.
	self createContentWrapperOn: aPageElement.
	^ aPageElement
]

{ #category : #'widget configuration' }
GtPagerPageEmbellisher >> createContentWrapperOn: aPageElement [
	| aContentWrapper aCloseButton aMaximizeButton |
	aCloseButton := self newPageCloseButton.
	aMaximizeButton := self newMaximizeButton.
	aContentWrapper := self newPageContentWrapper.
	self addNextPageButtonInto: aContentWrapper.
	aContentWrapper addChild: self contentElement.
	aContentWrapper addChild: aCloseButton.
	aContentWrapper addChild: aMaximizeButton.
	aPageElement addChild: aContentWrapper.
]

{ #category : #'widget configuration' }
GtPagerPageEmbellisher >> createSelectionContextFromEvent: anEvent [
	| aContext |
	aContext := self newSelectionContext
		object: anEvent object;
		tool: anEvent tool;
		afterPage: self contentElement.
	self selectionContext: aContext.
	^ aContext
]

{ #category : #initialization }
GtPagerPageEmbellisher >> defaultPageWidth [
	^ GtPagerPageWidth weighted
]

{ #category : #initialization }
GtPagerPageEmbellisher >> initialize [
	super initialize.
	pageWidth := self defaultPageWidth.
	self initializePagerHolder.
	self initializeSelectionContext.
]

{ #category : #'instance creation' }
GtPagerPageEmbellisher >> newMaximizeButton [
	^ GtInspectorRoundButtonStencil normal asElement
		icon: GtInspectorPlusIconStencil add asElement;
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c margin:
					(BlInsets
						top: -10
						left: -10
						bottom: 0
						right: 0).
			c ignored horizontal alignLeft.
			c ignored vertical alignTop ];
		action: [ self pagerHolder maximizePageContent: self contentElement ]
]

{ #category : #'instance creation' }
GtPagerPageEmbellisher >> newNextPageButton [
	^ BrPagerNextButton new
		size: 16 @ 32;
		geometry:
			(BlPolygon
				vertices:
					{(0 @ 0).
					(16 @ 16).
					(0 @ 32)});
		background: ((Color fromHexString: #BDBDBD) alpha: 0.5);
		visibility: BlVisibility hidden;
		constraintsDo: [ :c | 
			c linear horizontal alignRight.
			c linear vertical alignCenter ];
		margin: (BlInsets all: 2);
		when: BlClickEvent
			do: [ :anEvent | 
				anEvent consumed: true.
				self pagerHolder spawn: self selectionContext.
				anEvent modifiers isShift
					ifTrue: [ self pagerHolder smoothScrollToLast ] ]
]

{ #category : #'instance creation' }
GtPagerPageEmbellisher >> newPageCloseButton [
	^ GtInspectorRoundButtonStencil normal asElement
		icon: GtInspectorPlusIconStencil close asElement;
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c
				margin:
					(BlInsets
						top: -10
						left: 0
						bottom: 0
						right: -10).
			c ignored horizontal alignRight.
			c ignored vertical alignTop ];
		action: [ self pagerHolder close: self contentElement ]
]

{ #category : #'instance creation' }
GtPagerPageEmbellisher >> newPageContentWrapper [
	^ BrPagerPageContentElement new
		clipChildren: false;
		background: Color white;
		viewModel: (BrInteractiveModel new addState: BrFocusModel new);
		look: BrGlamorousFocusableShadowLook new;
		layout: BlLinearLayout vertical;
		margin:
			(BlInsets
				top: 15
				right: 0
				bottom: 10
				left: 15);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ]
]

{ #category : #'instance creation' }
GtPagerPageEmbellisher >> newPageElement [
	| aPageElement |

	aPageElement := BrPagerPageElement new
		layout: BlLinearLayout horizontal;
		margin: (BlInsets all: 0);
		constraintsDo: [ :c | c vertical matchParent ].		

	self pageWidth embellishPage: aPageElement.
	
	^ aPageElement
]

{ #category : #'instance creation' }
GtPagerPageEmbellisher >> newSelectionContext [
	^ GtPagerPageSelectionContext new
]

{ #category : #accessing }
GtPagerPageEmbellisher >> pageWidth [
	<return: #GtPagerPageWidth>
	^ pageWidth
]

{ #category : #accessing }
GtPagerPageEmbellisher >> pageWidth: aGtPagerPageWidth [
	self 
		assert: [ aGtPagerPageWidth isNotNil ] 
		description: [ 'Page width must be non-nil' ].
	pageWidth := aGtPagerPageWidth
]

{ #category : #'api - configuration' }
GtPagerPageEmbellisher >> pager: aGtPager [
	pagerHolder := GtPagerHolder new pager: aGtPager.
]

{ #category : #accessing }
GtPagerPageEmbellisher >> pagerHolder [
	<return: #GtPagerHolder>
	^ pagerHolder
]

{ #category : #'api - configuration' }
GtPagerPageEmbellisher >> removePager: aGtPager [
	pagerHolder := GtPagerHolder null.
]
