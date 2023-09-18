Extension { #name : #MCHttpRepository }

{ #category : #'*GToolkit-Inspector' }
MCHttpRepository >> gtDisplayOn: aStream [
	aStream nextPutAll: self location
]
