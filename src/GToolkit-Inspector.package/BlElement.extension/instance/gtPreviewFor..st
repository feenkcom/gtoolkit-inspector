*GToolkit-Inspector
gtPreviewFor: aView
	<gtView>
	^ aView explicit 
		title: 'Preview';
		priority: 1;
		stencil: [ BlElement new background: self asSpartaForm ]