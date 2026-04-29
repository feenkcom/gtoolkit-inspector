Extension { #name : #OCParseTreeRewriter }

{ #category : #'*GToolkit-Inspector' }
OCParseTreeRewriter >> gtTreeSourceCodeFor: aView [
	<gtView>
	self tree ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Source code';
		object: [ self tree ];
		view: #gtSourceCodeFor:
]
