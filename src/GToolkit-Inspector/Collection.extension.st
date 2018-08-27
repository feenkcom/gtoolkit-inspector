Extension { #name : #Collection }

{ #category : #'*GToolkit-Inspector' }
Collection >> gtItemsFor: aView [
	<gtView>
	^ aView explicit
		title: 'Items';
		priority: 50;
		stencil: [ 
			| list |
			list := BrColumnedList new
				addEventHandler: GtInspectorListToSelectHandler new;
				display: self asOrderedCollection.
			list column
				title: 'Item';
				stencil: [ :each :anIndex | BrListLabelStencil new text: each gtDisplayString ].
			list ]
]
