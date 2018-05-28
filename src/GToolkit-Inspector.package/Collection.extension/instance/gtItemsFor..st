*GToolkit-Inspector
gtItemsFor: aView
	<gtView: 10>
	^ aView
		title: 'Items';
		stencil: [ 
			BrSimpleList new
				display: self;
				stencil: [ :each :anIndex | BrListLabelStencil new text: each gtDisplayString ] ]