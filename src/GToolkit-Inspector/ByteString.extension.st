Extension { #name : #ByteString }

{ #category : #'*GToolkit-Inspector' }
ByteString >> gtDirectoryFor: aView [
	<gtView>
	(self asFileReference exists and: [self asFileReference isDirectory]) ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'Directory';
		object: [ self asFileReference ];
		view: #gtTreeFor:
]

{ #category : #'*GToolkit-Inspector' }
ByteString >> gtFileContentsFor: aView [
	<gtView>
	(self asFileReference exists and: [self asFileReference isDirectory not]) ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'File contents';
		object: [ self asFileReference ];
		view: #gtContentsFor:
]
