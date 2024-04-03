Extension { #name : #Integer }

{ #category : #'*GToolkit-Inspector' }
Integer >> gtPreviewFor: aView [
	<gtView>
	^ aView explicit
		title: 'Preview';
		priority: 1;
		stencil: [ 
			| aNumberElement |
			aNumberElement := BrLabel new 
				text: (String streamContents: [ :out |
							self
								printSeparatedBy: Character space
								every: 3
								signed: false
								on: out ]);
				aptitude: (BrGlamorousLabelAptitude new fontSize: 20) + BrShadowAptitude;
				background: Color white;
				margin: (BlInsets all: 20);
				padding: (BlInsets all: 10);
				layout: BlLinearLayout horizontal;
				constraintsDo: [ :c | 
					c vertical fitContent.
					c horizontal fitContent.
					c frame horizontal alignCenter.
					c frame vertical alignCenter ].
			BlElement new 
				constraintsDo: [:c | 
					c vertical matchParent.
					c horizontal matchParent];
				layout: BlFrameLayout new;
				addChild: aNumberElement ]
]
