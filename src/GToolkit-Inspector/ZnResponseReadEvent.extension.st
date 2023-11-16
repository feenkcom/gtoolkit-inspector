Extension { #name : #ZnResponseReadEvent }

{ #category : #'*GToolkit-Inspector' }
ZnResponseReadEvent >> gtDetails [
	^ super gtDetails ,
		{ 
			{#response 
				. String streamContents: [ :out | 
					self response statusLine printCodeAndReasonOn: out.
					self response hasEntity ifTrue: [ 
						out space.self response entity printContentTypeAndLengthOn: out ] ]
				 . self response } .
			{#duration
				. (self duration printString , 'ms')
				. self duration} }
]
