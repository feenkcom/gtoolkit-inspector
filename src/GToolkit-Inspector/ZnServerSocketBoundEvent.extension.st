Extension { #name : #ZnServerSocketBoundEvent }

{ #category : #'*GToolkit-Inspector' }
ZnServerSocketBoundEvent >> gtDetails [
	^ super gtDetails ,
		{
			{#address
				. String streamContents: [ :out | self class printAddress: self address on: out ] 
				. self address} .
			{#port . self port} }
]
