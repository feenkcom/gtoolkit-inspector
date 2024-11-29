Extension { #name : #False }

{ #category : #'*GToolkit-Inspector' }
False >> gtColoredText [
	^ 'false' asRopedText foreground: BrGlamorousColors errorBorderColor
]

{ #category : #'*GToolkit-Inspector' }
False >> gtLiveBackground [
	^ BrGlamorousColors errorBackgroundColor
]
