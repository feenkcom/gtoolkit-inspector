ui
gtViewWithExceptionInStencilFor: aView
	<gtView: 0>
	^ aView
		title: 'With error in stencil';
		stencil: [ 
			1/0.
			BlElement new ]