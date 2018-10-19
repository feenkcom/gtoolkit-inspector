Class {
	#name : #GtInspectorPagerPageEmbellisher,
	#superclass : #BrPagerPageEmbellisher,
	#instVars : [
		'inspector',
		'width',
		'resizedAction',
		'selectedObject',
		'selectedElement',
		'systemChangesHandler'
	],
	#category : #'GToolkit-Inspector'
}

{ #category : #'api - instantiation' }
GtInspectorPagerPageEmbellisher >> create [
	<return: #BlElement>
	| aPageElement aContentWrapper aPageResizer aTriangleElement aCloseButton aMaximizeButton |
	self contentElement removeFromParent.
	aTriangleElement := self createNextPageButton.
	aCloseButton := self createPageCloseButton.
	aMaximizeButton := self createMaximizeButton.
	aPageElement := self createPage.
	aContentWrapper := self createPageContentWrapper.
	aContentWrapper
		when: GtPhlowObjectToSelect
		do: [ :anEvent | 
			selectedObject := anEvent object.
			aTriangleElement visibility: BlVisibility visible.
			self inspector
				select: self selectedObject
				after: self contentElement ].
	aContentWrapper
		when: GtPhlowObjectToSpawn
		do: [ :anEvent | 
			selectedObject := anEvent object.
			aTriangleElement visibility: BlVisibility visible.
			self inspector
				spawn: self selectedObject
				after: self contentElement ].
	aPageResizer := self createResizerForPage: aPageElement.
	aContentWrapper addChild: self contentElement.
	aContentWrapper addChild: aCloseButton.
	aContentWrapper addChild: aMaximizeButton.
	(self contentElement viewModel model isKindOf: GtPlayBook)
		ifFalse: [ self createObjectPlaygroundIn: aContentWrapper ].
	aPageElement addChild: aContentWrapper.
	aPageElement addChild: aPageResizer.
	aPageElement addChild: aTriangleElement.
	self inspector pager
		when: BrPagerPageAddedEvent
		do: [ :anEvent | self updateCloseButtonVisiblity: aCloseButton ].
	self inspector pager
		when: BrPagerPageRemovedEvent
		do: [ :anEvent | self updateCloseButtonVisiblity: aCloseButton ].
	self inspector pager
		when: BrPagerPagesChanged
		do: [ :anEvent | self updateCloseButtonVisiblity: aCloseButton ].
	self updateCloseButtonVisiblity: aCloseButton.

	"systemChangesHandler subscribe: MethodAdded, MethodModified, MethodRemoved
		send: #handleMethodAnnouncement:
		to: self
		for: aPageElement."
	^ aPageElement
]

{ #category : #'api - instantiation' }
GtInspectorPagerPageEmbellisher >> createMaximizeButton [
	^ GtInspectorRoundButtonStencil normal asElement
		icon: GtInspectorPlusIconStencil add asElement;
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c
				margin:
					(BlInsets
						top: -10
						left: -10
						bottom: 0
						right: 0).
			c ignored horizontal alignLeft.
			c ignored vertical alignTop ];
		action: [ self createMaximizedContentElement ]
]

{ #category : #'api - instantiation' }
GtInspectorPagerPageEmbellisher >> createMaximizedContentElement [
	| anOverlay aPreviousParent aMinimizeButton anOverlayContent |
	aPreviousParent := self contentElement parent.
	self contentElement removeFromParent.
	anOverlayContent := BlElement new.
	anOverlay := BlOverlayElement new.
	anOverlay
		background: (Color white alpha: 0.8);
		padding: (BlInsets all: 20);
		attachTo: self inspector;
		layout: BlLinearLayout horizontal.
	anOverlayContent
		background: (Color white);
		look: BrShadowLook new;
"		border: (BlBorder paint: BrGlamorousColors lightBorderColor width: 1);
"		constraintsDo: [ :c | c horizontal matchParent. c vertical matchParent ];
		clipChildren: false;
		addChild: self contentElement.
	anOverlay addChild: anOverlayContent.
	aMinimizeButton := GtInspectorRoundButtonStencil normal asElement
		icon: GtInspectorMinusIconStencil minus asElement;
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c margin: (BlInsets top: -10 left: -10 bottom: 0 right: 0).
			c ignored horizontal alignLeft.
			c ignored vertical alignTop ];
		action: [ 
			self contentElement removeFromParent.
			aPreviousParent addChildFirst: self contentElement.
			anOverlay removeFromParent ].
	anOverlayContent addChild: aMinimizeButton.
	^ self inspector addChild: anOverlay
]

{ #category : #'api - instantiation' }
GtInspectorPagerPageEmbellisher >> createNextPageButton [
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

{ #category : #'api - instantiation' }
GtInspectorPagerPageEmbellisher >> createObjectPlaygroundIn: aContentWrapper [
	| aPlaygroundContainer aContentToPlaygroundResizer aPlayground playbook |
	aPlaygroundContainer := BlElement new
		padding: (BlInsets all: 10);
		layout: BlLinearLayout new;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: 0 ].
	playbook := GtPlayPage forObject: self contentElement viewModel model.
	aPlayground := playbook asElement.
	aPlayground
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	aPlayground clipChildren: false.
	aPlaygroundContainer addChild: aPlayground.
	aContentToPlaygroundResizer := BlElement new
		layout: BlFrameLayout new;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: 8.
			c margin: (BlInsets left: 40 right: 40).
			c padding: (BlInsets all: 0) ];
		addChild:
			(BlElement new
				background: ((Color fromHexString: #BDBDBD) alpha: 0.5);
				geometry: (BlRectangle cornerRadius: 2);
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical exact: 3.
					c frame horizontal weight: 0.2.
					c frame vertical alignTop.
					c frame horizontal alignCenter ]);
		addEventHandler:
			(BlResizerTopListener new
				resizeTarget: aPlaygroundContainer;
				minimumExtent: 75 @ 0);
		when: BlDoubleClickEvent
			do: [ :e | aPlaygroundContainer height: 0 ].
	aContentWrapper addChild: aContentToPlaygroundResizer.
	aContentWrapper addChild: aPlaygroundContainer
]

{ #category : #'api - instantiation' }
GtInspectorPagerPageEmbellisher >> createPage [
	^ BrPagerPageElement new
		layout: BlLinearLayout horizontal;
		margin: (BlInsets all: 0);
		constraintsDo: [ :c | 
			c horizontal exact: self width.
			c vertical matchParent ]
]

{ #category : #'api - instantiation' }
GtInspectorPagerPageEmbellisher >> createPageCloseButton [
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
		action: [ self inspector close: self contentElement ]
]

{ #category : #'api - instantiation' }
GtInspectorPagerPageEmbellisher >> createPageContentWrapper [
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

{ #category : #'api - instantiation' }
GtInspectorPagerPageEmbellisher >> createResizerForPage: aPageElement [
	^ BrPagerPageResizerElement new
		layout: BlFrameLayout new;
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal exact: 8.
			c margin: (BlInsets top: 40 bottom: 40).
			c padding: BlInsets empty ];
		addChild:
			(BlElement new
				background: ((Color fromHexString: #BDBDBD) alpha: 0.5);
				geometry: (BlRectangle cornerRadius: 2);
				constraintsDo: [ :c | 
					c vertical matchParent.
					c horizontal exact: 3.
					c frame vertical weight: 0.2.
					c frame horizontal alignLeft.
					c frame vertical alignCenter ]);
		addEventHandler:
			(BlResizerRightListener new
				resizeTarget: aPageElement;
				minimumExtent: 75 @ 75);
		when: BlResizerResizedEvent
			do: [ :anEvent | resizedAction cull: anEvent extent ];
		when: BlDoubleClickEvent
			do: [ :anEvent | 
			| myPageModel myWidth |
			anEvent consumed: true.
			myWidth := self inspector pager width / 2.
			myPageModel := self contentElement viewModel.
			myPageModel embellisher width: myWidth.
			aPageElement width: myWidth ]
]

{ #category : #private }
GtInspectorPagerPageEmbellisher >> handleMethodAnnouncement: aMethodAnnouncement [
	(selectedObject isKindOf: aMethodAnnouncement methodClass) 
		ifTrue: [ self inform: 'refresh'. self create ]
]

{ #category : #initialization }
GtInspectorPagerPageEmbellisher >> initialize [
	super initialize.
	
	width := 400.
	resizedAction := [  ]
]

{ #category : #accessing }
GtInspectorPagerPageEmbellisher >> inspector [
	^ inspector
]

{ #category : #accessing }
GtInspectorPagerPageEmbellisher >> inspector: aGtInspector [
	inspector := aGtInspector
]

{ #category : #accessing }
GtInspectorPagerPageEmbellisher >> selectedObject [
	^ selectedObject
]

{ #category : #accessing }
GtInspectorPagerPageEmbellisher >> selectedObject: anObject [
	selectedObject := anObject
]

{ #category : #private }
GtInspectorPagerPageEmbellisher >> updateCloseButtonVisiblity: aCloseButton [
	((self contentElement viewModel = self inspector pager pages last)
		and: [ (self contentElement viewModel ~= self inspector pager pages first) ])
			ifTrue: [ aCloseButton visibility: BlVisibility visible ]
			ifFalse: [ aCloseButton visibility: BlVisibility hidden ]
]

{ #category : #enumerating }
GtInspectorPagerPageEmbellisher >> whenResizedDo: aBlock [
	resizedAction := aBlock
]

{ #category : #accessing }
GtInspectorPagerPageEmbellisher >> width [
	^ width
]

{ #category : #accessing }
GtInspectorPagerPageEmbellisher >> width: aNumber [
	width := aNumber
]
