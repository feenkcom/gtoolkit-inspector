Extension { #name : #BlWrappedText }

{ #category : #'*GToolkit-Inspector' }
BlWrappedText >> gtInnerTextAttributeTreeFor: aView [
	<gtView>
	^ aView forward
		title: 'Inner text attributes';
		priority: 12;
		object: [ self text ];
		view: #gtAttributeTreeFor:
]

{ #category : #'*GToolkit-Inspector' }
BlWrappedText >> gtInnerTextFor: aView [
	<gtView>
	^ aView text
		title: 'Inner text';
		text: text;
		priority: 11
]
