Extension { #name : #Integer }

{ #category : #'*GToolkit-Inspector' }
Integer >> gtIntegerFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Integer';
		items: [ | associations |
			associations :=	{
					'decimal' -> self printString.
					'hex' -> self printStringHex.
					'octal' -> (self printStringBase: 8).
					'binary' -> (self printStringBase: 2)} asOrderedCollection.
			(self between: 0 and: 16r10FFFF)
				ifTrue: [ associations add: 'character' -> self asCharacter ].
			associations ];
		column: 'Key' item: #key;
		column: 'Value' item: #value;
		send: #value
]
