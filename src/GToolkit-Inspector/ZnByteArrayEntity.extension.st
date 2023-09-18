Extension { #name : #ZnByteArrayEntity }

{ #category : #'*GToolkit-Inspector' }
ZnByteArrayEntity >> gtViewBytesFor: aView [
	<gtView>
	^ aView forward 
		title: 'Bytes';
		object: [ self bytes ];
		view: #gtBytesFor: 
]

{ #category : #'*GToolkit-Inspector' }
ZnByteArrayEntity >> gtViewContentHexDumpFor: aView [
	<gtView>
	^ aView forward 
		title: 'Hex dump';
		object: [ self bytes ];
		view: #gtHexDumpFor: 
]
