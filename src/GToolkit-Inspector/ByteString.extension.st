Extension { #name : #ByteString }

{ #category : #'*GToolkit-Inspector' }
ByteString >> gtBase64EncodedPngFor: aView [
	<gtView>
	| prefix |
	prefix := 'data:image/png;base64,'.
	self beginsWith: prefix.
	^ aView forward
		title: 'PNG';
		object: [ | form bytes base64 |
			base64 := self removePrefix: prefix.
			bytes := base64 base64Decoded.
			form := ImageReadWriter formFromStream: bytes readStream.
			form ];
		view: #gtFormFor:
]

{ #category : #'*GToolkit-Inspector' }
ByteString >> gtDirectoryFor: aView [
	<gtView>
	| fileReference |
	self size > 1024 ifTrue: [ ^ aView empty ].
	[ fileReference := self asFileReference ]
		on: FileException
		do: [ ^ aView empty ].

	[ (fileReference exists and: [ fileReference isDirectory ])
		ifFalse: [ ^ aView empty ] ] on: FileException do: [ ^ aView empty ].

	^ aView forward
		title: 'Directory';
		object: [ fileReference ];
		view: #gtTreeFor:
]

{ #category : #'*GToolkit-Inspector' }
ByteString >> gtFileContentsFor: aView [
	<gtView>
	| fileReference |
	self size > 1024 ifTrue: [ ^ aView empty ].
	[ fileReference := self asFileReference ]
		on: FileException
		do: [ ^ aView empty ].

	[ (fileReference exists and: [ fileReference isDirectory not ])
		ifFalse: [ ^ aView empty ] ] on: FileException do: [ ^ aView empty ].

	^ aView forward
		title: 'File contents';
		object: [ fileReference ];
		view: #gtContentsFor:
]
