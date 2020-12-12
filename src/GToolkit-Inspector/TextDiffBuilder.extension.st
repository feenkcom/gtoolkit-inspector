Extension { #name : #TextDiffBuilder }

{ #category : #'*GToolkit-Inspector' }
TextDiffBuilder >> asElement [
	^ (GtDiffElement on: self) look: GtDiffShadowLook
]
