Extension { #name : #ZipArchiveMember }

{ #category : #'*GToolkit-Inspector' }
ZipArchiveMember >> gtBytes [
	<return: #ByteArray>
	| aStream |
	aStream := (ByteArray new: self uncompressedSize) writeStream.
	self extractTo: aStream.
	^ aStream contents
]

{ #category : #'*GToolkit-Inspector' }
ZipArchiveMember >> gtContents [
	<return: #String or: #ByteArray>
	"Answer my contents as a string."
	^ self isTextFile 
		ifFalse: [ self gtBytes ] 
		ifTrue: [ self gtBytes utf8Decoded ]
]

{ #category : #'*GToolkit-Inspector' }
ZipArchiveMember >> gtContentsFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Contents';
		text: [ 
			[ self contents asByteArray utf8Decoded asRopedText ]
				on: Error do: [ :anException |
					self contents asString asRopedText ] ]
]
