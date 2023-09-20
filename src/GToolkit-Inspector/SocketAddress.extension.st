Extension { #name : #SocketAddress }

{ #category : #'*GToolkit-Inspector' }
SocketAddress >> gtDisplayOn: stream [
	"Overwrite to get standard object behaviour"
	
	^ self printOn: stream
]
