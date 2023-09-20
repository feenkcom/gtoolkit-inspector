Extension { #name : #MCPackageManager }

{ #category : #'*GToolkit-Inspector' }
MCPackageManager >> gtDisplayOn: stream [
	stream nextPutAll: self package name
]
