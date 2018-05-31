*GToolkit-Inspector
gtPackagesFor: aView
	<gtView: 20>
	^ aView
		title: 'Packages';
		stencil: [ BrSimpleList new display: [ self packages ] ]