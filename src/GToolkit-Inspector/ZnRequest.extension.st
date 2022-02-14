Extension { #name : #ZnRequest }

{ #category : #'*GToolkit-Inspector' }
ZnRequest >> gtRequestQueryFor: aView [
	<gtView>
	^ aView forward
		title: 'Request Query';
		priority: 45;
		object: [ self requestLine ];
		view: #gtQueryFor:
]

{ #category : #'*GToolkit-Inspector' }
ZnRequest >> gtViewRequestLineTextFor: aView [
	<gtView>
	^ aView forward
		title: 'Request';
		priority: 45;
		object: [ self requestLine ];
		view: #gtViewRequestLineTextFor:
]
