*GToolkit-Inspector
gtPreviewFor: aView
	<gtView: 0>
	^ aView 
		title: 'Preview';
		stencil: [ BlElement new background: self asSpartaForm ]