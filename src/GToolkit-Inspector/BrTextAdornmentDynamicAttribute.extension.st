Extension { #name : #BrTextAdornmentDynamicAttribute }

{ #category : #'*GToolkit-Inspector' }
BrTextAdornmentDynamicAttribute >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		stencil: [ 
			| aContainer |
			aContainer := BrVerticalPane new
				matchParent;
				alignCenter;
				margin: (BlInsets all: 10);
				addChildren: stencilBuilder build asOrderedCollection.
			aContainer 
				addChild: (BrLabel new
					aptitude: (BrGlamorousLabelAptitude new
						foreground: Color gray);
					text: 'Number of elements: ', aContainer childrenCount asString;
					constraintsDo: [ :c | 
						c ignoreByLayout.
						c ignored horizontal alignRight.
						c ignored vertical alignTop.
						c margin: (BlInsets all: 0) ]).
			aContainer ]
]
