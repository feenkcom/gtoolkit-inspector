Extension { #name : #Integer }

{ #category : #'*GToolkit-Inspector' }
Integer >> gtPreviewFor: aView [
	<gtView>
	^ aView explicit
		title: 'Preview';
		priority: 1;
		stencil: [ | thousandsGroups container |
			thousandsGroups := $| split: (String streamContents: [ :out |
				self printSeparatedBy: $| every: 3 signed: false on: out ]).
			container := BlElement new
				layout: (BlLinearLayout horizontal cellSpacing: 1);
				margin: (BlInsets all: 4);
				constraintsDo: [ :c | 
					c horizontal fitContent.
					c vertical fitContent ].
			thousandsGroups do: [ :each | | thousandsContainer |
				thousandsContainer := BlElement new
					layout: BlLinearLayout vertical;
					constraintsDo: [ :c | 
						c horizontal fitContent.
						c vertical fitContent ].
				thousandsContainer addChild: (BrLabel new
					aptitude: (BrGlamorousLabelAptitude new fontSize: 32);
					text: each).
				thousandsContainer addChild: (BlElement new 
					background: Color gray; 
					height: 1;
					margin: (BlInsets all: 4);
					constraintsDo: [ :c | c horizontal matchParent ]).
				container addChild: thousandsContainer ].
			container ]
]
