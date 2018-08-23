*GToolkit-Inspector
gtPillarCommentFor: aView
	<gtView>
	^ aView explicit
		title: 'Comment';
		priority: 10;
		stencil: [ GtDocumenter editorForText: self comment ]