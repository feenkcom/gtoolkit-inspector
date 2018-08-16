ui
gtViewWithExceptionInStencilFor: aView
	<gtView: 0>
	^ aView explicit
		title: 'With error in stencil';
		stencil: [ 
			1/0.
			BlElement new ]