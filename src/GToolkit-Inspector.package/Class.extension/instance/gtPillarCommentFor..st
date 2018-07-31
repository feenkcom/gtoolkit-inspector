*GToolkit-Inspector
gtPillarCommentFor: aView
	<gtView: 23>
	^ aView
		title: 'Comment';
		stencil: [ GtDocumenter editorForText: self comment ]