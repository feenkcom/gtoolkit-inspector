Extension { #name : #ZnClientConnectionClosedEvent }

{ #category : #'*GToolkit-Inspector' }
ZnClientConnectionClosedEvent >> gtDetails [
	^ super gtDetails ,
		{
			{#address
				. String streamContents: [ :out | self class printAddress: self address on: out ] 
				. self address} .
			{#port . self port} }
]
