*GToolkit-Inspector
gtPillarCommentFor: aView
	<gtView>
	^ aView explicit
		title: 'Comment';
		priority: 20;
		stencil: [ GtDocumenter editorForText: self comment ]