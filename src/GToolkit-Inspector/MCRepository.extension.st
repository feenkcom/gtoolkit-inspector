Extension { #name : #MCRepository }

{ #category : #'*GToolkit-Inspector' }
MCRepository >> gtDisplayOn: aStream [
	aStream nextPutAll: self description
]
