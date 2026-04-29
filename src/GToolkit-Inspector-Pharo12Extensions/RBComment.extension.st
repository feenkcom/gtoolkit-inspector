Extension { #name : #RBComment }

{ #category : #'*GToolkit-Inspector-Pharo12Extensions' }
RBComment >> gtContentsFor: aView [
	<gtView>
	self contents ifNil: [ ^ aView empty ].
	^ aView textEditor 
			title: 'Method comment';
			text: [ self contents ]
]
