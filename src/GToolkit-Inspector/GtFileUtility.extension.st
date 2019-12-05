Extension { #name : #GtFileUtility }

{ #category : #'*GToolkit-Inspector' }
GtFileUtility class >> imageElementFromBytes: theBytes named: aFileName [
	"It returns a text editor if an unsupported image"
	<return: #BlElement> 
	theBytes isNil ifTrue: [^ BlElement new asPannableElement].
	^ (theBytes readStreamDo: [ :aReadSteam | ImageReadWriter gtReaderClassFromStream: aReadSteam ])
		ifNil: [ BrEditorElement new 
			editor: (BrTextEditor new 
				text: ('Unsupported format for ', aFileName asString) asRopedText);
			constraintsDo: [ :c | c vertical matchParent. c horizontal matchParent ] ]
		ifNotNil: [ :aReaderClass | 
			(aReaderClass gtFormFromBuffer: theBytes) asElement asPannableElement ]
]

{ #category : #'*GToolkit-Inspector' }
GtFileUtility class >> imageElementFromFileReference: aFileReference [
	"It returns a text editor if an unsupported image"
	<return: #BlElement> 
	aFileReference exists ifFalse: [^ BlElement new asPannableElement].
	^ (ImageReadWriter gtReaderClassFromFileReference: aFileReference)
		ifNil: [ BrEditorElement new 
			editor: (BrTextEditor new 
				text: ('Unsupported format for ', aFileReference fullName asString) asRopedText);
			constraintsDo: [ :c | c vertical matchParent. c horizontal matchParent ] ]
		ifNotNil: [ :aReaderClass | 
			(aReaderClass gtFormFromFileReference: aFileReference) asElement asPannableElement ] 
]
