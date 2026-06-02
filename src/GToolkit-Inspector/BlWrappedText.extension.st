Extension { #name : #BlWrappedText }

{ #category : #'*GToolkit-Inspector' }
BlWrappedText >> gtAttributeTreeFor: aView [
	^ self gtInnerTextAttributeTreeFor: aView
]

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

{ #category : #'*GToolkit-Inspector' }
BlWrappedText >> gtIntervalTreeFor: aView [
	<gtView>
	^ aView forward
		title: 'Inner text intervals';
		priority: 13;
		object: [ self text ];
		view: #gtIntervalTreeFor:
]
