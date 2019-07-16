Extension { #name : #PrettyTextDiffBuilder }

{ #category : #'*GToolkit-Inspector' }
PrettyTextDiffBuilder >> newStyler [
	^ BrRBTextStyler new classOrMetaClass: sourceClass
]
