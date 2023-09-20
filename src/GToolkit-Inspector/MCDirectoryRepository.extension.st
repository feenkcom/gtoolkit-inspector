Extension { #name : #MCDirectoryRepository }

{ #category : #'*GToolkit-Inspector' }
MCDirectoryRepository >> gtDisplayOn: aStream [
	aStream nextPutAll: self description
]
