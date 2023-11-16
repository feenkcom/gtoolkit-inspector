Extension { #name : #ZnRequestResponseHandledEvent }

{ #category : #'*GToolkit-Inspector' }
ZnRequestResponseHandledEvent >> gtDetails [
	^ super gtDetails ,
		{ 
			{#request 
				. String streamContents: [ :out | 
					self request requestLine printMethodAndUriOn: out ]
				. self request} .
			{#response 
				. String streamContents: [ :out | 
					self response statusLine printCodeAndReasonOn: out.
					self response hasEntity ifTrue: [ 
						out space.
						self response entity printContentTypeAndLengthOn: out ] ]
				. self response } .
			{#duration
				. (self duration printString , 'ms') 
				. self duration} }
]
