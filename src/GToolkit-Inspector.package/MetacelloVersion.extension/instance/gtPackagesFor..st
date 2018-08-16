*GToolkit-Inspector
gtPackagesFor: aView
	<gtView: 20>
	^ aView explicit
		title: 'Packages';
		stencil: [ BrSimpleList new display: [ self packages ] ]