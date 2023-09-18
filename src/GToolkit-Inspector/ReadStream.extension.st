Extension { #name : #ReadStream }

{ #category : #'*GToolkit-Inspector' }
ReadStream >> gtStreamStateFor: aView [
	<gtView>
	self position ifNil: [ ^ aView empty ].
	^ aView textEditor
		title: 'Contents';
		text: [ 
			| aText |
			aText := self contents asRopedText.
			(aText from: 1 to: self position) underlineColor: BrGlamorousColors errorBackgroundColor.
			aText ]
]
