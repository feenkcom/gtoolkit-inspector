Extension { #name : #ZnLogEvent }

{ #category : #'*GToolkit-Inspector' }
ZnLogEvent >> gtDetails [
	^ {
		{#id . self id}.
		{#timestamp
			. (ZTimestampFormat fromString: '2001-02-03 16:05:06 .7 +00:00') format: self timestamp
			. self timestamp}.
		{#name . self name}.
		{#processId . self processId} }
]

{ #category : #'*GToolkit-Inspector' }
ZnLogEvent >> gtViewDetailsIn: composite [
	<gtView>
	^ composite columnedList
		title: 'Details';
		items: [ self gtDetails ];
		column: 'Key' text: #first;
		column: 'Value' text: #second;
		send: #last
]
