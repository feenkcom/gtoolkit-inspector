Extension { #name : #Magnitude }

{ #category : #'*GToolkit-Inspector' }
Magnitude >> gtLiveFor: aView [

	^ self gtPreviewFor: aView
]

{ #category : #'*GToolkit-Inspector' }
Magnitude >> gtPreviewFor: aView [
	<gtView>
	^ aView explicit
		title: 'Preview';
		priority: 1;
		stencil: [ 
			| aNumberElement |
			aNumberElement := BrLabel new 
				text: self gtDisplayString;
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
