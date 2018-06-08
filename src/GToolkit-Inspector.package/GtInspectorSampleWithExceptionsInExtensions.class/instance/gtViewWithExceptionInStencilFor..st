ui
gtViewWithExceptionInStencilFor: aView
	<gtView: 0>
	^ aView
		title: 'Empty';
		stencil: [ 
			1/0.
			BlElement new ]