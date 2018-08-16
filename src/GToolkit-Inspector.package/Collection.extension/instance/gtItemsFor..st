*GToolkit-Inspector
gtItemsFor: aView
	<gtView: 0>
	^ aView explicit
		title: 'Items';
		stencil: [ 
			BrSimpleList new
				addEventHandler: GtInspectorListToSpawnHandler new;
				display: self asOrderedCollection;
				stencil: [ :each :anIndex | BrListLabelStencil new text: each gtDisplayString ] ]