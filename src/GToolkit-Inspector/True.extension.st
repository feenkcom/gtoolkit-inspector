Extension { #name : #True }

{ #category : #'*GToolkit-Inspector' }
True >> gtColoredText [
	^ 'true' asRopedText foreground: BrGlamorousColors successBorderColor
]

{ #category : #'*GToolkit-Inspector' }
True >> gtLiveBackground [
	^ BrGlamorousColors successBackgroundColor
]
