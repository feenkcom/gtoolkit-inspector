Extension { #name : #SocketStream }

{ #category : #'*GToolkit-Inspector' }
SocketStream >> gtViewSocketInfoFor: aView [
	<gtView>
	self socket ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Socket Info';
		priority: 55;
		object: [ self socket ];
		view: #gtViewSocketInfoFor:
]
