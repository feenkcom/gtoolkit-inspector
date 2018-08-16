api - instantiation
create
	<return: #BlElement>
	| aPageElement aResizer |

	aPageElement := BlElement new
		look: BrShadowLook new;
		background: Color white;
		layout: BlLinearLayout vertical;
		margin: (BlInsets all: 10);
		padding: (BlInsets all: 5);
		constraintsDo: [ :c |
			c horizontal exact: self width.
			c vertical matchParent ].

	aResizer := BlElement new
		layout: BlFrameLayout new;
		constraintsDo: [ :c |
			c ignoreByLayout.
			c vertical matchParent.
			c horizontal exact: 10.
			c padding: (BlInsets top: 0 right: 3 bottom: 0 left: 0).
			c ignored vertical alignCenter.
			c ignored horizontal alignRight ];
		addChild: (BlElement new
			background: (Color gray alpha: 0.4);
			geometry: (BlRectangle cornerRadius: 2);
			constraintsDo: [ :c |
				c vertical matchParent.
				c horizontal exact: 3.
				c frame vertical weight: 0.2.
				c frame horizontal alignRight.
				c frame vertical alignCenter ]
		);
		addEventHandler: (BlResizerRightListener new resizeTarget: aPageElement; minimumExtent: 75@75);
		when: BlResizerResizedEvent do: [ :anEvent | resizedAction cull: anEvent extent ].
	
	self contentElement removeFromParent.
	aPageElement addChild: self contentElement.
	aPageElement addChild: aResizer.

	^ aPageElement