Extension { #name : #UndefinedObject }

{ #category : #'*GToolkit-Inspector' }
UndefinedObject >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		stencil: [ 
			BlElement new
				layout: BlFrameLayout new;
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent ];
				addChild: (
					BlElement new
						aptitude: BrShadowAptitude new;
						background: Color white;
						constraintsDo: [ :c |
							c frame horizontal alignCenter.
							c frame vertical alignCenter.
							c horizontal fitContent.
							c vertical fitContent ];
						layout: BlLinearLayout horizontal;
						addChild: (BlElement new background: BrGlamorousColors disabledButtonTextColor; constraintsDo: [:c | c vertical matchParent. c horizontal exact: 30 ]);
						addChild: (BrLabel new
							text: self asString;
							aptitude: BrGlamorousLabelAptitude;
							layout: BlLinearLayout vertical alignCenter;
							padding: (BlInsets all: 10))) ]
]
