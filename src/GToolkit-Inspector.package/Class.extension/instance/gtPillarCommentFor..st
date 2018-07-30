*GToolkit-Inspector
gtPillarCommentFor: aView
	<gtView: 10>
	^ aView
		title: '_Comment';
		stencil: [ GtDocumenter editorForText: self comment ]