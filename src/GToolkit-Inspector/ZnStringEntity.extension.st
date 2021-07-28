Extension { #name : #ZnStringEntity }

{ #category : #'*GToolkit-Inspector' }
ZnStringEntity >> gtTextFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Contents';
		text: [ self string ]
]
