api - instantiation
create
	<return: #BlElement>
	| aPageElement aResizer aContentWrapper |

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
			c horizontal exact: 15.
			c padding: (BlInsets top: 0 right: 3 bottom: 0 left: 0) ];
		addChild: (BlElement new
			background: (Color gray alpha: 0.4);
			geometry: (BlRectangle cornerRadius: 2);
			constraintsDo: [ :c |
				c vertical matchParent.
				c horizontal exact: 3.
				c frame vertical weight: 0.2.
				c frame horizontal alignRight.
				c frame vertical alignCenter ]);
		addEventHandler: (BlResizerRightListener new resizeTarget: aPageElement; minimumExtent: 75@75);
		when: BlResizerResizedEvent do: [ :anEvent | resizedAction cull: anEvent extent ].
	
	self contentElement removeFromParent.
	aContentWrapper addChild: self contentElement.
	aPageElement addChild: aContentWrapper.
	aPageElement addChild: aResizer.

	^ aPageElement