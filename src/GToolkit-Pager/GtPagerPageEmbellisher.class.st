Class {
	#name : #GtPagerPageEmbellisher,
	#superclass : #BrPagerPageEmbellisher,
	#instVars : [
		'pageWidth',
		'pagerHolder'
	],
	#category : #'GToolkit-Pager-Stencils'
}

{ #category : #'api - instantiation' }
GtPagerPageEmbellisher >> create [
	<return: #BlElement>
	| aPageElement |
	aPageElement := self newPageElement.
	self createContentWrapperOn: aPageElement.
	^ aPageElement
]

{ #category : #'instance creation' }
GtPagerPageEmbellisher >> createContentWrapperOn: aPageElement [
	| aContentWrapper aCloseButton aMaximizeButton |
	aCloseButton := self newPageCloseButton.
	aMaximizeButton := self newMaximizeButton.
	aContentWrapper := self newPageContentWrapper.
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

{ #category : #configuration }
GtPagerPageEmbellisher >> pager: aGtPager [
	pagerHolder := GtPagerHolder new pager: aGtPager.
]

{ #category : #configuration }
GtPagerPageEmbellisher >> pagerHolder [
	<return: #GtPagerHolder>
	^ pagerHolder
]

{ #category : #configuration }
GtPagerPageEmbellisher >> removePager: aGtPager [
	pagerHolder := GtPagerHolder null.
]
