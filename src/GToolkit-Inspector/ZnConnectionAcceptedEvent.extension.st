Extension { #name : #ZnConnectionAcceptedEvent }

{ #category : #'*GToolkit-Inspector' }
ZnConnectionAcceptedEvent >> gtDetails [
	^ super gtDetails ,
		{
			{#address
				. String streamContents: [ :out | self class printAddress: self address on: out ] 
				. self address} }
]
