Extension { #name : #GtFileUtility }

{ #category : #'*GToolkit-Inspector' }
GtFileUtility class >> imageElementFromBytes: theBytes named: aFileName [
	"It returns a text editor if an unsupported image"
	<return: #BlElement> 
	| image |

	(theBytes isNil or: [ theBytes isEmpty ]) ifTrue: [^ BlElement new asPannableElement].
	image := SkiaImage fromBuffer: theBytes start: 0 end: theBytes size - 1.
	^ image isNull ifTrue:
		[ BrEditorElement new 
			editor: (BrTextEditor new 
				text: ('Unsupported format for ', aFileName asString) asRopedText);
			constraintsDo: [ :c | c vertical matchParent. c horizontal matchParent ] ]
	ifFalse:
		[ image asElement 
			constraintsDo: [ :c |
					c vertical matchParent.
					c horizontal matchParent. ] ]
]

{ #category : #'*GToolkit-Inspector' }
GtFileUtility class >> imageElementFromFileReference: aFileReference [
	"It returns a text editor if an unsupported image"
	<return: #BlElement> 
	| image buffer valid |

	aFileReference exists ifFalse: [^ BlElement new asPannableElement].
	aFileReference fileSystem isDiskFileSystem ifTrue: 
		[ valid := true.
		image := BlFileImageElement file: aFileReference ]
	ifFalse: 
		[ buffer := aFileReference binaryReadStreamDo: [ :s | s upToEnd ].
		image := SkiaImage fromBuffer: buffer start: 0 end: buffer size - 1.
		valid := image isNull not ].
	
	^ valid ifFalse: 
		[ BrEditorElement new 
			editor: (BrTextEditor new 
				text: ('Unsupported format for ', aFileReference fullName asString) asRopedText);
			constraintsDo: [ :c | c vertical matchParent. c horizontal matchParent ] ]
	ifTrue: 
		[ image asElement
				constraintsDo: [ :c |
					c vertical matchParent.
					c horizontal matchParent. ] ] 
]
