Extension { #name : #ZnRequestLine }

{ #category : #'*GToolkit-Inspector' }
ZnRequestLine >> gtQueryFor: aView [
	<gtView>
	^ aView forward
		title: 'Query';
		priority: 2;
		object: [ self uri ];
		view: #gtQueryFor:
]

{ #category : #'*GToolkit-Inspector' }
ZnRequestLine >> gtViewRequestLineTextFor: aView [
	<gtView>
	^ aView textEditor
		title: 'HTTP';
		priority: 1;
		text: [ String streamContents: [ :out | self writeOn: out ] ]
]
