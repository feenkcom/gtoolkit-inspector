Extension { #name : #ZnLogEvent }

{ #category : #'*GToolkit-Inspector' }
ZnLogEvent >> gtDetails [
	^ {
		{#id . self id}.
		{#timestamp . self timestamp}.
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
