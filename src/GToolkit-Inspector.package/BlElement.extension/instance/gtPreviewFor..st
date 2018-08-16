*GToolkit-Inspector
gtPreviewFor: aView
	<gtView: 0>
	^ aView explicit 
		title: 'Preview';
		stencil: [ BlElement new background: self asSpartaForm ]