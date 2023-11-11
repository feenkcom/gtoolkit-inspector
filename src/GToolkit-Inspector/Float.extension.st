Extension { #name : #Float }

{ #category : #'*GToolkit-Inspector' }
Float >> gtFloatIn: aView [
	<gtView>
	^ aView columnedList 
		title: 'Float';
		items: [ {
			'decimal' -> self.
			'binary' -> self binaryLiteralString.
			'significand' -> self significand.
			'exponent' -> self exponent } asOrderedCollection ];
		column: 'Key' text: #key;
		column: 'Value' text: #value;
		send: #value
]

{ #category : #'*GToolkit-Inspector' }
Float >> gtInspectorVariableNodesIn: aCollection [
	
	aCollection
		add: (GtInspectorDynamicNode hostObject: self label: '1' value: (self at: 1));
		add: (GtInspectorDynamicNode hostObject: self label: '2' value: (self at: 2))
]
