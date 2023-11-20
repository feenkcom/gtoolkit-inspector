Extension { #name : #UUID }

{ #category : #'*GToolkit-Inspector' }
UUID >> gtUUIDDetailsFor: aView [
	<gtView>
	^ aView columnedList
		  title: 'Details';
		  priority: 10;
		  items: [ { 
			('string' -> self printString).
			('string36' -> self asString36).
			('hex' -> self hex) } ];
		  column: 'Key' text: #key;
		  column: 'Value' text: #value weight: 5;
		  send: #value
]
