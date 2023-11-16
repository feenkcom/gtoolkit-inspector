Extension { #name : #ZnClientTransactionEvent }

{ #category : #'*GToolkit-Inspector' }
ZnClientTransactionEvent >> gtDetails [
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
						out space.self response entity printContentTypeAndLengthOn: out ] ]
				 . self response } .
			{#requestDuration
				. (self requestDuration printString , 'ms') 
				. self requestDuration} .
			{#responseDuration
				. (self responseDuration printString , 'ms')
				. self responseDuration} }
]
