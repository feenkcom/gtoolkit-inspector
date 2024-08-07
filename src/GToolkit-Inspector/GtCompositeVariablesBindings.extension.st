Extension { #name : #GtCompositeVariablesBindings }

{ #category : #'*GToolkit-Inspector' }
GtCompositeVariablesBindings >> gtBindingsFor: aView [
	<gtView>

	^ aView columnedTree
		title: 'Bindings';
		priority: 10;
		items: [ bindings ];
		children: [ :eachBindings |
			(eachBindings isKindOf: GtVariableBindingsWithVariable)
				ifTrue: [ #() ]
				ifFalse: [ eachBindings bindingNames collect: [ :eachName | 
					GtVariableBindingsWithVariable new
						bindings: eachBindings;
						variable: (eachBindings bindingOf: eachName) ] ] ];
		column: 'Name' text: [ :each |
			(each isKindOf: GtVariableBindingsWithVariable)
				ifTrue: [ each name ]
				ifFalse: [ each class name ] ];
		column: 'Value' text: [ :each |
			(each isKindOf: GtVariableBindingsWithVariable)
				ifTrue: [ each value ]
				ifFalse: [ '' ] ];
		send: [ :each | each value ]
]
