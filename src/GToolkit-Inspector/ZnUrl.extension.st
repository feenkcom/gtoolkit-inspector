Extension { #name : #ZnUrl }

{ #category : #'*GToolkit-Inspector' }
ZnUrl >> gtUrlFor: aView [
	<gtView>
	^ aView explicit
		title: 'URL';
		priority: 1;
		stencil: [ 
			| docTemplate |
			docTemplate := '*{1}*

[[[smalltalk
ZnClient new get: ''{1}''.
]]]'.
			GtDocument new 
				text: (docTemplate format: { self printString }); 
				asElementWithoutSaveAction ]
]
