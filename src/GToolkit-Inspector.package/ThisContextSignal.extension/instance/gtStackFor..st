*GToolkit-Inspector
gtStackFor: aView
	<gtView: 0>
	^ aView explicit
		title: 'Stack';
		stencil: [ BrSimpleList new display: self stack ]