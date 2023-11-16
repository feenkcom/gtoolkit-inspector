Extension { #name : #ZnServerConnectionClosedEvent }

{ #category : #'*GToolkit-Inspector' }
ZnServerConnectionClosedEvent >> gtDetails [
	^ super gtDetails ,
		{
			{#address
				. String streamContents: [ :out | self class printAddress: self address on: out ] 
				. self address} }
]
