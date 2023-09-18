Extension { #name : #BlWrappedText }

{ #category : #'*GToolkit-Inspector' }
BlWrappedText >> gtInnerTextFor: aView [
	<gtView>
	^ aView text
		title: 'Inner text';
		text: text;
		priority: 11
]
