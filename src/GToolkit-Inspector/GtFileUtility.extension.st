Extension { #name : #GtFileUtility }

{ #category : #'*GToolkit-Inspector' }
GtFileUtility class >> imageElementFromBytes: theBytes named: aFileName [
	"It returns a text editor if an unsupported image"
	<return: #BlElement> 

	(theBytes isNil or: [ theBytes isEmpty ]) ifTrue: [^ BlElement new asPannableElement].
	^ (BlSpartaBufferedImageElement buffer: theBytes)
		errorText: 'Unable to decode ', aFileName asString;
		constraintsDo: [ :c |
					c vertical matchParent.
					c horizontal matchParent. ]
]

{ #category : #'*GToolkit-Inspector' }
GtFileUtility class >> imageElementFromFileReference: aFileReference [
	"It returns a text editor if an unsupported image"
	<return: #BlElement> 
	| image buffer |

	aFileReference exists ifFalse: [^ BlElement new asPannableElement].
	image := aFileReference fileSystem isDiskFileSystem ifTrue: 
		[ BrAsyncFileWidget new file: aFileReference ]
	ifFalse: 
		[ buffer := aFileReference binaryReadStreamDo: [ :s | s upToEnd ].
		BlSpartaBufferedImageElement buffer: buffer ].
	
	^ image
		constraintsDo: [ :c |
					c vertical matchParent.
					c horizontal matchParent. ]
]
