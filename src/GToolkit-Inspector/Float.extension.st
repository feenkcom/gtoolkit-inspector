Extension { #name : #Float }

{ #category : #'*GToolkit-Inspector' }
Float >> gtInspectorVariableNodesIn: aCollection [
	
	aCollection
		add: (GtInspectorDynamicNode hostObject: self label: '1' value: (self at: 1));
		add: (GtInspectorDynamicNode hostObject: self label: '2' value: (self at: 2))
]
