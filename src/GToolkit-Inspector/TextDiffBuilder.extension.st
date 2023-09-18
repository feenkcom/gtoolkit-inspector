Extension { #name : #TextDiffBuilder }

{ #category : #'*GToolkit-Inspector' }
TextDiffBuilder >> asElement [
	^ (GtDiffElement onDiff: self) aptitude: GtDiffShadowAptitude
]
