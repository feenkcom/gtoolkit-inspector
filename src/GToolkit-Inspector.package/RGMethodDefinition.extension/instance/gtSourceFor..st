*GToolkit-Inspector
gtSourceFor: aView
	<gtView: 0>
	^ aView  
		title: 'Source';
		stencil: [ BrTextEditor onMethod: self ].