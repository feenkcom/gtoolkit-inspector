Extension { #name : #GtSharedVariablesBindings }

{ #category : #'*GToolkit-Inspector' }
GtSharedVariablesBindings >> gtBindingsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Bindings';
		priority: 10;
		items: [ self gtBindingsWithVariable ];
		column: 'Name' text: [ :each | each name allButFirst ];
		column: 'Value' text: [ :each | each value ];
		column: 'Actions'
			stencil: [ :each | 
				| element |
				element := BrToolbar new
						aptitude: (BrGlamorousToolbarAptitude new spacing: 5);
						fitContent;
						addItem: (BrButton new
								aptitude: BrGlamorousButtonWithIconAptitude;
								icon: BrGlamorousVectorIcons remove;
								label: 'Remove ' , each name , ' from bindings';
								beTinySize;
								action: [ self removeBindingOf: each name allButFirst.
									element phlow firstParentWithViewContent
										ifNotNil: [ :anElement | anElement phlow update ]
										ifNil: [ element phlow fireToolUpdateWish ] ]) ]
			width: 80;
		send: #value
]
