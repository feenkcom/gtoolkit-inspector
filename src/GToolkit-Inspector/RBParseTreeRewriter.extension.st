Extension { #name : #RBParseTreeRewriter }

{ #category : #'*GToolkit-Inspector' }
RBParseTreeRewriter >> gtTreeSourceCodeFor: aView [
	<gtView>
	tree ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Source code';
		object: [ tree ];
		view: #gtSourceCodeFor:
]
