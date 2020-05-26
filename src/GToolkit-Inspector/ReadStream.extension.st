Extension { #name : #ReadStream }

{ #category : #'*GToolkit-Inspector' }
ReadStream >> gtStreamStateFor: aView [
	<gtView>
	self position ifNil: [ ^ aView empty ].
	^ aView textEditor
		title: 'Contents';
		text: [ 
			| aText |
			aText := self contents asRopedText monospace.
			(aText from: 1 to: self position) 
				underlinePaint: BrGlamorousColors errorBackgroundColor
				width: 1.
			aText
			]
]
