Extension { #name : #BlText }

{ #category : #'*GToolkit-Inspector' }
BlText >> gtTextFor: aView [
	<gtView>
	^ aView textEditor 
		title: 'Text';
		text: self
]
