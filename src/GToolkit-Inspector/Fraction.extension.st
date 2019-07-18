Extension { #name : #Fraction }

{ #category : #'*GToolkit-Inspector' }
Fraction >> gtPreviewFor: aView [
	<gtView>
	^ aView explicit
		title: 'Preview';
		stencil: [ 
			| overallElement fractionElement |
			fractionElement := BlElement new 
				layout: BlLinearLayout vertical;
				constraintsDo: [ :c | c linear vertical alignCenter. c vertical fitContent ];
				addChild: (BlTextElement new 
					text: self numerator asString asRopedText;
					constraintsDo: [:c | 
						c linear horizontal alignCenter]);
				addChild: (BlElement new height: 2; background: Color black; margin: (BlInsets top: 5 bottom: 5) );
				addChild: (BlTextElement new 
					text: self denominator asString asRopedText;
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
				addChild: (BlTextElement new 
					margin: (BlInsets left: 5 right: 5); 
					text: '=' asRopedText;
					constraintsDo: [:c | c linear vertical alignCenter ]);
				addChild: (BlTextElement new 
					text: self asFloat asString asRopedText;
					constraintsDo: [:c | c linear vertical alignCenter ]).
			BlElement new 
				constraintsDo: [:c | 
					c vertical matchParent.
					c horizontal matchParent];
				layout: BlFrameLayout new;
				addChild: overallElement ]
]
