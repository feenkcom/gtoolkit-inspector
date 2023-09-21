Extension { #name : #TGtVariablesBindings }

{ #category : #'*GToolkit-Inspector' }
TGtVariablesBindings >> gtBindingsFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Bindings';
		priority: 10;
		items: [ self bindingNames collect: [ :eachName | self bindingOf: eachName ] ];
		column: 'Name' text: [ :each | each name asSymbol printString ];
		column: 'Value' text: [ :each | each value ]
]
