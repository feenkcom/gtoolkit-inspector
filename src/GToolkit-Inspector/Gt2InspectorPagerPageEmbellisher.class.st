Class {
	#name : #Gt2InspectorPagerPageEmbellisher,
	#superclass : #BrPagerPageEmbellisher,
	#instVars : [
		'inspector',
		'width',
		'weight',
		'resizedAction',
		'selectedObject',
		'selectedElement',
		'systemChangesHandler',
		'isExact'
	],
	#category : #'GToolkit-Inspector-! New - UI'
}

{ #category : #accessing }
Gt2InspectorPagerPageEmbellisher >> beExact: aNumber [
	self width: aNumber.
	isExact := true.
]

{ #category : #accessing }
Gt2InspectorPagerPageEmbellisher >> beExact: aNumber page: aPageElement [

	aPageElement width: aNumber.
	self beExact: aNumber.
]

{ #category : #accessing }
Gt2InspectorPagerPageEmbellisher >> beMatching: aWeight [
	self weight: aWeight.
	isExact := false.
]

{ #category : #accessing }
Gt2InspectorPagerPageEmbellisher >> beMatching: aNumber page: aPageElement [
	aPageElement weight: aNumber.
	aPageElement constraintsDo: [ :c | c horizontal matchParent ].
	self beMatching: aNumber.
]

{ #category : #'api - instantiation' }
Gt2InspectorPagerPageEmbellisher >> create [
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
Gt2InspectorPagerPageEmbellisher >> createMaximizeButton [
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
Gt2InspectorPagerPageEmbellisher >> createMaximizedContentElement [
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
		constraintsDo: [ :c | c horizontal matchParent. c vertical matchParent ];
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
Gt2InspectorPagerPageEmbellisher >> createNextPageButton [
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
Gt2InspectorPagerPageEmbellisher >> createObjectPlaygroundIn: aContentWrapper [
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
	aContentToPlaygroundResizer := GtInspectorPagePlaygroundResizer new
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
Gt2InspectorPagerPageEmbellisher >> createPage [
	| aPageElement |

	aPageElement := GtInspectorPageElement new
		layout: BlLinearLayout horizontal;
		margin: (BlInsets all: 0);
		constraintsDo: [ :c | c vertical matchParent ].
		
	self isExact
		ifTrue: [ aPageElement width: self width ]
		ifFalse: [ aPageElement
				weight: self weight;
				constraintsDo: [ :c | c horizontal matchParent ] ].
		
	^ aPageElement
]

{ #category : #'api - instantiation' }
Gt2InspectorPagerPageEmbellisher >> createPageCloseButton [
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
Gt2InspectorPagerPageEmbellisher >> createPageContentWrapper [
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
Gt2InspectorPagerPageEmbellisher >> createResizerForPage: aPageElement [
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
			do: [ :anEvent |
				| myPageModel |
				resizedAction cull: anEvent extent.
				myPageModel := self contentElement viewModel.
				myPageModel embellisher
					beExact: anEvent extent x
					page: aPageElement
			];
		when: BlDoubleClickEvent
			do: [ :anEvent | 
			| myPageModel |
			anEvent consumed: true.
			myPageModel := self contentElement viewModel.
			myPageModel embellisher
				beMatching: (self inspector computePageWeightFor: myPageModel model)
				page: aPageElement ]
]

{ #category : #private }
Gt2InspectorPagerPageEmbellisher >> handleMethodAnnouncement: aMethodAnnouncement [
	(selectedObject isKindOf: aMethodAnnouncement methodClass) 
		ifTrue: [ self inform: 'refresh'. self create ]
]

{ #category : #initialization }
Gt2InspectorPagerPageEmbellisher >> initialize [
	super initialize.
	
	width := 400.
	weight := 0.5.
	isExact := false.
	
	resizedAction := [  ]
]

{ #category : #accessing }
Gt2InspectorPagerPageEmbellisher >> inspector [
	^ inspector
]

{ #category : #accessing }
Gt2InspectorPagerPageEmbellisher >> inspector: aGtInspector [
	inspector := aGtInspector
]

{ #category : #accessing }
Gt2InspectorPagerPageEmbellisher >> isExact [
	^ isExact
]

{ #category : #accessing }
Gt2InspectorPagerPageEmbellisher >> selectedObject [
	^ selectedObject
]

{ #category : #accessing }
Gt2InspectorPagerPageEmbellisher >> selectedObject: anObject [
	selectedObject := anObject
]

{ #category : #private }
Gt2InspectorPagerPageEmbellisher >> updateCloseButtonVisiblity: aCloseButton [
	((self contentElement viewModel = self inspector pager pages last)
		and: [ (self contentElement viewModel ~= self inspector pager pages first) ])
			ifTrue: [ aCloseButton visibility: BlVisibility visible ]
			ifFalse: [ aCloseButton visibility: BlVisibility hidden ]
]

{ #category : #accessing }
Gt2InspectorPagerPageEmbellisher >> weight [
	^ weight
]

{ #category : #accessing }
Gt2InspectorPagerPageEmbellisher >> weight: aNumber [
	weight := aNumber
]

{ #category : #enumerating }
Gt2InspectorPagerPageEmbellisher >> whenResizedDo: aBlock [
	resizedAction := aBlock
]

{ #category : #accessing }
Gt2InspectorPagerPageEmbellisher >> width [
	^ width
]

{ #category : #accessing }
Gt2InspectorPagerPageEmbellisher >> width: aNumber [
	width := aNumber
]
