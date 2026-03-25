Extension { #name : #OCCommentNode }

{ #category : #'*GToolkit-Inspector' }
OCCommentNode >> gtContentsFor: aView [
	<gtView>
	self contents ifNil: [ ^ aView empty ].
	^ aView textEditor 
			title: 'Method comment';
			text: [ self contents ]
]
