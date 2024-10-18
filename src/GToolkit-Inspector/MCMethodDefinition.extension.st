Extension { #name : #MCMethodDefinition }

{ #category : #'*GToolkit-Inspector' }
MCMethodDefinition >> gtDetailsFor: composite [
	<gtView>
	^ composite columnedList
		title: 'Details';
		priority: 30;
		items: [ {
			{ 'class name' . self className }.
			{ 'meta' . self classIsMeta }.
			{ 'full class name' . self fullClassName }.
			{ 'selector' . self selector printString }.
			{ 'protocol' . self protocol }.
			{ 'extension' . self isExtensionMethod }.
			{ 'summary' . self gtSummary }.
		} ];
		column: 'key' text: #first;
		column: 'value' text: #second weight: 3;
		send: #last
]

{ #category : #'*GToolkit-Inspector' }
MCMethodDefinition >> gtSummary [

	^ self fullClassName , '>>' , selector printString
]

{ #category : #'*GToolkit-Inspector' }
MCMethodDefinition >> gtViewDefinitionSourceFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Definition';
		priority: 20;
		glamorousCodeFont;
		styler: [ BrRBTextStyler new ];
		text: [ self source ]
]
