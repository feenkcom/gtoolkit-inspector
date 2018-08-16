*GToolkit-Inspector
gtBlocConnectedExamplesIn: aView
	<gtView: 30>
	^ aView explicit 
		title: 'Connected (Bloc)';
		stencil: [ 
			| connector |
			connector := GtConnector new.
			connector addMethod: self method.
			connector asScalableElement ]