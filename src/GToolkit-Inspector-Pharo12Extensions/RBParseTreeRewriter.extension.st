Extension { #name : #RBParseTreeRewriter }

{ #category : #'*GToolkit-Inspector-Pharo12Extensions' }
RBParseTreeRewriter >> gtTreeSourceCodeFor: aView [
	<gtView>
	tree ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Source code';
		object: [ tree ];
		view: #gtSourceCodeFor:
]
