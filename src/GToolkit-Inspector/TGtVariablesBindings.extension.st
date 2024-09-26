Extension { #name : #TGtVariablesBindings }

{ #category : #'*GToolkit-Inspector' }
TGtVariablesBindings >> gtBindingsFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Bindings';
		priority: 10;
		items: [ self gtBindingsWithVariable ];
		column: 'Name' text: [ :each | each name ];
		column: 'Value' text: [ :each | each value ];
		send: #value
]

{ #category : #'*GToolkit-Inspector' }
TGtVariablesBindings >> gtBindingsWithVariable [
	^ self bindingNames sorted collect: [ :eachName | 
			GtVariableBindingsWithVariable new
				bindings: self;
				variable: (self bindingOf: eachName) ] 
]
