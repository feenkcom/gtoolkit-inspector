ui
gtViewWithExceptionInStencilFor: aView
"	<gtView: 0>"
	^ aView
		title: 'Empty';
		stencil: [ 
			BlElement new.
			"1/0" ]