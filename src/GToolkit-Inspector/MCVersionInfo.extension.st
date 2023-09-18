Extension { #name : #MCVersionInfo }

{ #category : #'*GToolkit-Inspector' }
MCVersionInfo >> gtDisplayOn: stream [
	stream nextPutAll: self name
]
