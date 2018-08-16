*GToolkit-Inspector
gtPillarCommentFor: aView
	<gtView: 23>
	^ aView explicit
		title: 'Comment';
		stencil: [ GtDocumenter editorForText: self comment ]