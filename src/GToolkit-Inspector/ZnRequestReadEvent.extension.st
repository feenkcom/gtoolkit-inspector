Extension { #name : #ZnRequestReadEvent }

{ #category : #'*GToolkit-Inspector' }
ZnRequestReadEvent >> gtDetails [
	^ super gtDetails ,
		{ 
			{#request 
				. String streamContents: [ :out | 
					self request requestLine printMethodAndUriOn: out ]
				. self request} .
			{#duration
				. (self duration printString , 'ms')
				. self duration} }
]
