Extension { #name : #ZnConnectionEstablishedEvent }

{ #category : #'*GToolkit-Inspector' }
ZnConnectionEstablishedEvent >> gtDetails [
	^ super gtDetails ,
		{
			{#hostname . self hostname} .
			{#address 
				. String streamContents: [ :out | self class printAddress: self address on: out ] 
				. self address} .
			{#port . self port} .
			{#duration
				. (self duration printString , 'ms')
				. self duration} .
			{#proxy
				. self proxy ifNil: [ '' ] 
				. self proxy} }
]
