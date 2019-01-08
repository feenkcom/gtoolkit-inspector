Extension { #name : #AbstractFileReference }

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtJsonFor: aView [
	<gtView>
	(self isFile and: [ (GtFileUtility mimeTypeOfExtension: self extension) 
		= ZnMimeType applicationJson ]) ifFalse: [ ^ aView empty ].
	^ self gtRawJsonFor: aView
]
