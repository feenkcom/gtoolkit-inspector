Extension { #name : #Duration }

{ #category : #'*GToolkit-Inspector' }
Duration >> gtViewDetailsIn: composite [
	<gtView>
	^ composite columnedList
		title: 'Details';
		items: [ {('human readable' -> self humanReadablePrintString).
			('days' -> self days).
			('hours' -> self hours).
			('minutes' -> self minutes).
			('seconds' -> self seconds).
			('nanoseconds' -> self nanoSeconds)} ];
		column: 'Key' item: #key;
		column: 'Value' item: #value;
		send: #value
]
