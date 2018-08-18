*GToolkit-Inspector
gtItemsFor: aView
	<gtView: 0>
	^ aView explicit
		title: 'Items';
		stencil: [ 
			BrSimpleList new
				addEventHandler: GtInspectorListToSelectHandler new;
				display: self asOrderedCollection;
				stencil: [ :each :anIndex | BrListLabelStencil new text: each gtDisplayString ] ]