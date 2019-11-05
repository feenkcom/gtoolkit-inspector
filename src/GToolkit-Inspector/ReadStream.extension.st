Extension { #name : #ReadStream }

{ #category : #'*GToolkit-Inspector' }
ReadStream >> gtStreamStateFor: aView [
	<gtView>
	self position ifNil: [ ^ aView empty ].
	^ aView textEditor
		title: 'Contents';
		text: [ 
			| aText aStart |
			aText := self contents asRopedText monospace.
			aStart := self position isZero ifTrue: [ 0 ] ifFalse: [ 1 ].
			(aText from: aStart to: self position) 
				underlinePaint: BrGlamorousColors errorBackgroundColor
				width: 1.
			aText
			]
]
