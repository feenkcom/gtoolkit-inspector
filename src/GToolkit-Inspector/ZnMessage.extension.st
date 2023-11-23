Extension { #name : #ZnMessage }

{ #category : #'*GToolkit-Inspector' }
ZnMessage >> gtBinaryContentsFor: aView [
	<gtView>
	self hasEntity ifFalse: [ ^ aView empty ].
	self contentType isBinary ifFalse: [ ^ aView empty ].
	^ ((Dictionary new at: 'entity' put: self entity; yourself)
		gtItemsFor: aView)
			title: 'Contents';
			priority: 40
]

{ #category : #'*GToolkit-Inspector' }
ZnMessage >> gtEntityFor: aView [
	<gtView>
	self hasEntity ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'Entity';
		priority: 35;
		object: [ self entity ];
		view: #gtEntityFor:
]

{ #category : #'*GToolkit-Inspector' }
ZnMessage >> gtHeadersFor: aView [
	<gtView>
	^ (self headers gtHeadersFor: aView)
			priority: 30;
			title: (self headers headers size asString, ' headers')
			
]

{ #category : #'*GToolkit-Inspector' }
ZnMessage >> gtTextContentsFor: aView [
	<gtView>
	self hasEntity ifFalse: [ ^ aView empty ].
	self contentType isBinary ifTrue: [ ^ aView empty ].
	^ (self contents gtStringFor: aView)
		title: 'Contents';
		priority: 40
]
