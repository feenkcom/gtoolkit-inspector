Extension { #name : #ZnMimePart }

{ #category : #'*GToolkit-Inspector' }
ZnMimePart >> gtBinaryContentsFor: aView [
	<gtView>
	self hasEntity ifFalse: [ ^ aView empty ].
	self contentType isBinary ifFalse: [ ^ aView empty ].
	^ ((Dictionary new at: 'entity' put: self entity; yourself)
		gtItemsFor: aView)
			title: 'Contents';
			priority: 40
]

{ #category : #'*GToolkit-Inspector' }
ZnMimePart >> gtTextContentsFor: aView [
	<gtView>
	self hasEntity ifFalse: [ ^ aView empty ].
	self contentType isBinary ifTrue: [ ^ aView empty ].
	^ (self contents gtStringFor: aView)
		title: 'Contents';
		priority: 40
]

{ #category : #'*GToolkit-Inspector' }
ZnMimePart >> gtViewBytesFor: aView [
	<gtView>
	self hasEntity ifFalse: [ ^ aView empty ].
	self entity isByteArrayEntity ifFalse: [ ^ aView empty ].
	^ aView forward 
		title: 'Bytes';
		priority: 46;
		object: [ self entity ];
		view: #gtViewBytesFor:
]

{ #category : #'*GToolkit-Inspector' }
ZnMimePart >> gtViewContentHexDumpFor: aView [
	<gtView>
	self hasEntity ifFalse: [ ^ aView empty ].
	self entity isByteArrayEntity ifFalse: [ ^ aView empty ].
	^ aView forward 
		title: 'Hex dump';
		priority: 45;
		object: [ self entity ];
		view: #gtViewContentHexDumpFor:
]

{ #category : #'*GToolkit-Inspector' }
ZnMimePart >> gtViewHeadersFor: aView [
	<gtView>
	self hasHeaders ifFalse: [ aView empty ].
	^ aView forward
		title: 'Headers';
		priority: 30;
		object: [ self headers ];
		view: #gtHeadersFor: 
]
