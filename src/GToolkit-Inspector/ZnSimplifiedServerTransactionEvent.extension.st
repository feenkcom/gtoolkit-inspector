Extension { #name : #ZnSimplifiedServerTransactionEvent }

{ #category : #'*GToolkit-Inspector' }
ZnSimplifiedServerTransactionEvent >> gtDetails [
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
