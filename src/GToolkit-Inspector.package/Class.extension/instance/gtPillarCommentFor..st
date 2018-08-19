*GToolkit-Inspector
gtPillarCommentFor: aView
	<gtView>
	^ aView explicit
		title: 'Comment';
		stencil: [ GtDocumenter editorForText: self comment ]