Extension { #name : #MCPackage }

{ #category : #'*GToolkit-Inspector' }
MCPackage >> gtDisplayOn: aStream [
	aStream nextPutAll: self name
]
