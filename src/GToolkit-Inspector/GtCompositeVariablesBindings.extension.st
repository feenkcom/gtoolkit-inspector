Extension { #name : 'GtCompositeVariablesBindings' }

{ #category : '*GToolkit-Inspector' }
GtCompositeVariablesBindings >> gtBindingsFor: aView [
	<gtView>

	^ aView columnedTree
		title: 'Bindings';
		priority: 10;
		items: [ bindings ];
		children: [ :eachBindings |
			(eachBindings isKindOf: Variable)
				ifTrue: [ #() ]
				ifFalse: [ eachBindings bindingNames collect: [ :eachName | eachBindings bindingOf: eachName ] ] ];
		column: 'Name' text: [ :each |
			(each isKindOf: Variable)
				ifTrue: [ each name asSymbol printString ]
				ifFalse: [ each class name ] ];
		column: 'Value' text: [ :each |
			(each isKindOf: Variable)
				ifTrue: [ each value ]
				ifFalse: [ '' ] ]
]
