Extension { #name : #Fraction }

{ #category : #'*GToolkit-Inspector' }
Fraction >> gtPreviewFor: aView [
	^ aView explicit
		title: 'Preview';
		stencil: [ 
			| overallElement fractionElement |
			fractionElement := BlElement new 
				layout: BlLinearLayout vertical;
				constraintsDo: [ :c | c linear vertical alignCenter. c vertical fitContent ];
				addChild: (BrLabel new 
					look: BrGlamorousLabelLook;
					text: self numerator asString;
					constraintsDo: [:c | 
						c linear horizontal alignCenter]);
				addChild: (BlElement new height: 2; background: Color black; margin: (BlInsets top: 5 bottom: 5) );
				addChild: (BrLabel new 
					look: BrGlamorousLabelLook; 
					text: self denominator asString;
					constraintsDo: [:c | c linear horizontal alignCenter]).
			overallElement := BlElement new
				look: BrShadowLook new;
				background: Color white;
				margin: (BlInsets all: 20);
				padding: (BlInsets all: 10);
				layout: BlLinearLayout horizontal;
				constraintsDo: [ :c | 
					c vertical exact: 100.
					c horizontal fitContent.
					c frame horizontal alignCenter.
					c frame vertical alignCenter ];
				addChild: fractionElement;
				addChild: (BrLabel new 
					look: BrGlamorousLabelLook;
					margin: (BlInsets left: 5 right: 5); 
					text: '=';
					constraintsDo: [:c | c linear vertical alignCenter ]);
				addChild: (BrLabel new 
					look: BrGlamorousLabelLook;
					text: self asFloat asString;
					constraintsDo: [:c | c linear vertical alignCenter ]).
			BlElement new 
				constraintsDo: [:c | 
					c vertical matchParent.
					c horizontal matchParent];
				layout: BlFrameLayout new;
				addChild: overallElement ]
]
