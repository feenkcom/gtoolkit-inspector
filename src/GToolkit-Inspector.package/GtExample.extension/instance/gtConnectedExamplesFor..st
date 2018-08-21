*GToolkit-Inspector
gtConnectedExamplesFor: aView
	<gtView>
	^ aView explicit 
		title: 'Connected (Bloc)';
		stencil: [ 
			| connector |
			connector := GtConnector new.
			connector addMethod: self method.
			connector asScalableElement ]