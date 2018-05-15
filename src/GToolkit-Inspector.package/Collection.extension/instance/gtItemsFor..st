*GToolkit-Inspector
gtItemsFor: aView
	<gtView: 0>
	^ aView
		title: 'Items';
		stencil: [ 
			BrSimpleList new
				display: self;
				stencil: [ :each :anIndex | BrListLabelStencil new text: each gtDisplayString ] ]