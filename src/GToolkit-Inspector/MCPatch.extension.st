Extension { #name : #MCPatch }

{ #category : #'*GToolkit-Inspector' }
MCPatch >> gtViewOperationsIn: composite [
	<gtView>
	^ composite columnedList
		title: 'Operations';
		priority: 30;
		items: [ self operations ];
		column: 'Operation tyoe' text: [ :each | each class name ];
		column: 'Definition type' text: [ :each | each definition class name ];
		column: 'Definition summary' text: [ :each | each definition gtSummary ]
]
