Extension { #name : #ZnSimplifiedClientTransactionEvent }

{ #category : #'*GToolkit-Inspector' }
ZnSimplifiedClientTransactionEvent >> gtDetails [
	^ super gtDetails ,
		{ 
			{'request-method' . self method} . 
			{'request-url' . self url} . 
			{'response-code' . self responseCode} . 
			{'response-size'
				. self size printString , 'B'
				. self size} . 
			{#duration
				. (self duration printString , 'ms') 
				. self duration} }
]
