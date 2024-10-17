Extension { #name : #MCClassDefinition }

{ #category : #'*GToolkit-Inspector' }
MCClassDefinition >> gtDetailsFor: composite [
	<gtView>
	^ composite columnedList
		title: 'Details';
		priority: 30;
		items: [ {
			{ 'category' . self category }.
			{ 'name' . self className }.
			{ 'superclass name' . self superclassName }.
			{ 'class type' . self type }.
		} ];
		column: 'key' text: #first;
		column: 'value' text: #second weight: 3;
		send: #last
]

{ #category : #'*GToolkit-Inspector' }
MCClassDefinition >> gtViewClassDefinitionFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Definition';
		priority: 20;
		glamorousCodeFont;
		text: [ self source ]
]

{ #category : #'*GToolkit-Inspector' }
MCClassDefinition >> gtViewCommitIn: composite [
	<gtView>
	^ composite textEditor
		title: 'Comment';
		priority: 35;
		glamorousCodeFont;
		text: [ self comment ]
]
