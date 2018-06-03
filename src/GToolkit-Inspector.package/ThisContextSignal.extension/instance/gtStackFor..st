*GToolkit-Inspector
gtStackFor: aView
	<gtView: 0>
	^ aView 
		title: 'Stack';
		stencil: [ BrSimpleList new display: self stack ]