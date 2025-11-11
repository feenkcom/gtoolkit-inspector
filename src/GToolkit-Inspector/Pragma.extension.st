Extension { #name : #Pragma }

{ #category : #'*GToolkit-Inspector' }
Pragma >> gtDisplayOn: stream [
	self method displayStringOn: stream.
	stream space.
	self printOn: stream
]

{ #category : #'*GToolkit-Inspector' }
Pragma >> gtSourceFor: aView [
	<gtView> 
	^ aView forward
		title: 'Source';
		priority: 0;
		object: [ self method ];
		view: #gtSourceCodeFor:
]
