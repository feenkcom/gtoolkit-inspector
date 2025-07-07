Extension { #name : #ByteString }

{ #category : #'*GToolkit-Inspector' }
ByteString >> gtDirectoryFor: aView [
	<gtView>
	| fileReference |
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
