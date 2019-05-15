Extension { #name : #BlText }

{ #category : #'*GToolkit-Inspector' }
BlText >> gtStringFor: aView [
	<gtView>
	^ aView textEditor 
		title: 'String';
		text: [ self asString ]
]

{ #category : #'*GToolkit-Inspector' }
BlText >> gtTextFor: aView [
	<gtView>
	^ aView textEditor 
		title: 'Text';
		text: self
]
