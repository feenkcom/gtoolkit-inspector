Extension { #name : #BlChildren }

{ #category : #'*GToolkit-Inspector' }
BlChildren >> gtPreviewFor: aView [
	<gtView>
	^ aView explicit
		title: 'Preview';
		priority: 10;
		stencil: [
			| aContainer |
			
			aContainer := BlElement new.
			aContainer layout: BlFitLayout new.
			aContainer constraintsDo: [ :c |
				c horizontal fitContent.
				c vertical fitContent ].
			aContainer addChildren: (self collect: [ :eachChild |
				BlElement new
					size: eachChild measuredExtent;
					relocate: eachChild measuredBounds position;
					background: (Color gray alpha: 0.4);
					border: (BlBorder paint: Color white width: 1) ]).
			aContainer asScalableElement
			
		]
]
