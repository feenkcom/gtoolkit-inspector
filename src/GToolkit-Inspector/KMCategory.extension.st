Extension { #name : #KMCategory }

{ #category : #'*GToolkit-Inspector' }
KMCategory >> gtDisplayOn: stream [
	super displayStringOn: stream.
	^ stream
		nextPut: $(;
		nextPutAll: self name asString;
		nextPut: $)
]
