Extension { #name : #GtFileUtility }

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
