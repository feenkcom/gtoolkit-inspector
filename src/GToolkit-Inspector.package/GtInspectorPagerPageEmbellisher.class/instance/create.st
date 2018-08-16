api - instantiation
create
	<return: #BlElement>
	| aPageElement aContentWrapper aResizer aTriangleElement |

	self contentElement removeFromParent.
	
	aPageElement := BlElement new
		layout: BlLinearLayout horizontal;
		margin: (BlInsets all: 0);
		constraintsDo: [ :c |
			c horizontal exact: self width.
			c vertical matchParent ].

	aContentWrapper := BlElement new
		look: BrShadowLook new;
		background: Color white;
		layout: BlLinearLayout vertical;
		margin: (BlInsets top: 10 right: 0 bottom: 10 left: 5);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].

	aResizer := BlElement new
		layout: BlFrameLayout new;
		constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal exact: 8.
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

	aTriangleElement := BlElement new
		size: 16@32;
    	geometry: (BlPolygon vertices: { 0@0 . 16@16. 0@32 });
    	background: ((Color fromHexString: #BDBDBD) alpha: 0.5);
		constraintsDo: [ :c |
			c linear horizontal alignRight.
			c linear vertical alignCenter ];
		margin: (BlInsets all: 2).

	aContentWrapper addChild: self contentElement.
	aPageElement addChild: aContentWrapper.
	aPageElement addChild: aResizer.
	aPageElement addChild: aTriangleElement.

	^ aPageElement