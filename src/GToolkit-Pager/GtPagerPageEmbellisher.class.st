Class {
	#name : #GtPagerPageEmbellisher,
	#superclass : #BrPagerPageEmbellisher,
	#instVars : [
		'pageWidth',
		'pagerHolder',
		'selectedObject'
	],
	#category : #'GToolkit-Pager-Stencils'
}

{ #category : #'private - widget creation' }
GtPagerPageEmbellisher >> addNextPageButtonInto: aContentWrapper [
	| aTriangleElement |
	aTriangleElement := self newNextPageButton.
	aContentWrapper addChild: aTriangleElement.
	aContentWrapper
		when: GtPhlowObjectToSelect
		do: [ :anEvent | 
			self selectedObject: anEvent object.
			aTriangleElement visibility: BlVisibility visible.
			self pagerHolder
				select: self selectedObject
				after: self contentElement ].
	aContentWrapper
		when: GtPhlowObjectToSpawn
		do: [ :anEvent | 
			self selectedObject: anEvent object.
			aTriangleElement visibility: BlVisibility visible.
			self pagerHolder
				spawn: self selectedObject
				after: self contentElement ].
]

{ #category : #'api - instantiation' }
GtPagerPageEmbellisher >> create [
	<return: #BlElement>
	| aPageElement |
	aPageElement := self newPageElement.
	self createContentWrapperOn: aPageElement.
	^ aPageElement
]

{ #category : #'private - widget creation' }
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

{ #category : #initialization }
GtPagerPageEmbellisher >> defaultPageHolder [
	^ GtPagerHolder null
]

{ #category : #initialization }
GtPagerPageEmbellisher >> defaultPageWidth [
	^ GtPagerPageWidth weighted
]

{ #category : #initialization }
GtPagerPageEmbellisher >> initialize [
	super initialize.
	pageWidth := self defaultPageWidth.
	pagerHolder := self defaultPageHolder.
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
			self inspector
				spawn: self selectedObject
				after: self contentElement.
			anEvent modifiers isShift
				ifTrue: [ self inspector pager children second
						smoothScrollToPosition: self inspector pager pages size ] ]
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
		layout: BlLinearLayout vertical;
		margin: (BlInsets all: 0);
		constraintsDo: [ :c | c vertical matchParent ].		

	self pageWidth embellishPage: aPageElement.
	
	^ aPageElement
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

{ #category : #accessing }
GtPagerPageEmbellisher >> selectedObject [
	^ selectedObject
]

{ #category : #accessing }
GtPagerPageEmbellisher >> selectedObject: anObject [
	selectedObject := anObject
]
