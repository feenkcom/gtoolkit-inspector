*GToolkit-Inspector
gtProjectsFor: aView
	<gtView: 30>
	^ aView
		title: 'Projects';
		stencil: [ BrSimpleList new display: [ self projects ] ]