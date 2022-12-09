Extension { #name : #GtPharoMethodTestCaseState }

{ #category : #'*GToolkit-Inspector' }
GtPharoMethodTestCaseState class >> gtLiveFor: aView [
	<gtView>
	self hasAbstractMethods ifTrue: [ ^ aView empty ].

	^ aView explicit
		title: 'Live';
		priority: 1;
		stencil: [ BlElement new
				layout: BlFrameLayout new;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ];
				addChild: (BlElement new
						aptitude: BrShadowAptitude new;
						background: Color white;
						constraintsDo: [ :c | 
							c frame horizontal alignCenter.
							c frame vertical alignCenter.
							c horizontal fitContent.
							c vertical fitContent ];
						layout: BlLinearLayout horizontal;
						addChild: (BlElement new
								background: self color;
								border: self border;
								constraintsDo: [ :c | 
									c vertical matchParent.
									c horizontal exact: 30 ]);
						addChild: (BrLabel new
								text: self label;
								aptitude: BrGlamorousLabelAptitude;
								layout: BlLinearLayout vertical alignCenter;
								padding: (BlInsets all: 10))) ]
]

{ #category : #'*GToolkit-Inspector' }
GtPharoMethodTestCaseState class >> gtStatesFor: aView [
	<gtView>
	<gtClassView>
	self subclasses size = 0 ifTrue: [ ^ aView empty ].

	^ aView columnedList
		title: 'States';
		priority: 1;
		items: [ self allSubclasses ];
		column: 'Icon'
			icon: [ :aState | 
				BlElement new
					background: aState color;
					border: aState border;
					size: 16 @ 16 ]
			width: 32;
		column: 'State' text: [ :aState | aState label ]
]
