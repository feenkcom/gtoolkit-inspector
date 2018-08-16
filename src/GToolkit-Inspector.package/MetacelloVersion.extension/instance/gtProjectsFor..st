*GToolkit-Inspector
gtProjectsFor: aView
	<gtView: 30>
	^ aView explicit
		title: 'Projects';
		stencil: [ BrSimpleList new display: [ self projects ] ]