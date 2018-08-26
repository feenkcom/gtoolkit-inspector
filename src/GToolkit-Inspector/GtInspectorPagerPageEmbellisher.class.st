Class {
	#name : #GtInspectorPagerPageEmbellisher,
	#superclass : #BrPagerPageEmbellisher,
	#instVars : [
		'inspector',
		'width',
		'resizedAction',
		'selectedObject',
		'selectedElement'
	],
	#category : 'GToolkit-Inspector'
}

{ #category : #'api - instantiation' }
GtInspectorPagerPageEmbellisher >> create [
	<return: #BlElement>
	| aPageElement aContentWrapper aPageResizer aTriangleElement aCloseButton aContentToPlaygroundResizer |

	self contentElement removeFromParent.

	aTriangleElement := BlElement new
		size: 16@32;
    	geometry: (BlPolygon vertices: { 0@0 . 16@16. 0@32 });
    	background: ((Color fromHexString: #BDBDBD) alpha: 0.5);
		visibility: BlVisibility hidden;
		constraintsDo: [ :c |
			c linear horizontal alignRight.
			c linear vertical alignCenter ];
		margin: (BlInsets all: 2);
		when: BlClickEvent do: [ :anEvent |
			anEvent consumed: true.
			self inspector
				spawn: self selectedObject
				after: self contentElement ].

	aCloseButton := GtInspectorRoundButtonStencil normal asElement
		icon: (GtInspectorPlusIconStencil close asElement);
		constraintsDo: [ :c |
			c ignoreByLayout.
			c margin: (BlInsets top: -10 left: 0 bottom: 0 right: -10).
			c ignored horizontal alignRight.
			c ignored vertical alignTop ];
		action: [ self inspector close: self contentElement ].

	aPageElement := BlElement new
		layout: BlLinearLayout horizontal;
		margin: (BlInsets all: 0);
		constraintsDo: [ :c |
			c horizontal exact: self width.
			c vertical matchParent ].

	aContentWrapper := BlElement new
		look: BrShadowLook new;
		clipChildren: false;
		background: Color white;
		layout: BlLinearLayout vertical;
		margin: (BlInsets top: 15 right: 0 bottom: 10 left: 5);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].

	aContentWrapper when: GtPhlowObjectToSelect do: [ :anEvent |
		selectedObject := anEvent object.		
		aTriangleElement visibility: BlVisibility visible.
		self inspector
			select: self selectedObject
			after: self contentElement ].

	aContentWrapper when: GtPhlowObjectToSpawn do: [ :anEvent |
		selectedObject := anEvent object. 
		aTriangleElement visibility: (BlVisibility visible).
		self inspector
			spawn: self selectedObject
			after: self contentElement ].

	aPageResizer := BlElement new
		layout: BlFrameLayout new;
		constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal exact: 8.
			c margin: (BlInsets top: 40 bottom: 40).
			c padding: (BlInsets top: 0 right: 0 bottom: 0 left: 0) ];
		addChild: (BlElement new
			background: ((Color fromHexString: #BDBDBD) alpha: 0.5);
			geometry: (BlRectangle cornerRadius: 2);
			constraintsDo: [ :c |
				c vertical matchParent.
				c horizontal exact: 3.
				c frame vertical weight: 0.2.
				c frame horizontal alignLeft.
				c frame vertical alignCenter ]);
		addEventHandler: (BlResizerRightListener new resizeTarget: aPageElement; minimumExtent: 75@75);
		when: BlResizerResizedEvent do: [ :anEvent | resizedAction cull: anEvent extent ].

	aContentWrapper addChild: self contentElement.
	aContentWrapper addChild: aCloseButton.
	
	(self contentElement viewModel model isKindOf: GtPlayBook)
		ifFalse: [ 
			| aPlayground playbook |
			playbook := GtPlayPage new.
			playbook bindings at: #self put: self contentElement viewModel model.
			aPlayground := playbook asElement.
			aPlayground constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical exact: 0 ].
			aContentToPlaygroundResizer := BlElement new
				layout: BlFrameLayout new;
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical exact: 8.
					c margin: (BlInsets left: 40 right: 40).
					c padding: (BlInsets top: 0 right: 0 bottom: 0 left: 0) ];
				addChild: (BlElement new
					background: ((Color fromHexString: #BDBDBD) alpha: 0.5);
					geometry: (BlRectangle cornerRadius: 2);
					constraintsDo: [ :c |
						c horizontal matchParent.
						c vertical exact: 3.
						c frame horizontal weight: 0.2.
						c frame vertical alignTop.
						c frame horizontal alignCenter ]);
				addEventHandler: (BlResizerBottomListener new resizeTarget: self contentElement; minimumExtent: 75@75);
				addEventHandler: (BlResizerTopListener new resizeTarget: aPlayground; minimumExtent: 75@0);
				when: BlDoubleClickEvent do: [:e | aPlayground height: 0 ].

			aContentWrapper addChild: aContentToPlaygroundResizer.
			aContentWrapper addChild: aPlayground ].

	aPageElement addChild: aContentWrapper.
	aPageElement addChild: aPageResizer.
	aPageElement addChild: aTriangleElement.

	self inspector pager when: BrPagerPageAddedEvent do: [ :anEvent | self updateCloseButtonVisiblity: aCloseButton ].
	self inspector pager when: BrPagerPageRemovedEvent do: [ :anEvent | self updateCloseButtonVisiblity: aCloseButton ].
	self inspector pager when: BrPagerPagesChanged do: [ :anEvent | self updateCloseButtonVisiblity: aCloseButton ].

	self updateCloseButtonVisiblity: aCloseButton.
	
	^ aPageElement
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
