*GToolkit-Inspector
gtPillarCommentFor: aView
	<gtView: 23>
	^ aView
		title: 'Pillar Comment';
		stencil: [ GtDocumenter editorForText: self comment ]