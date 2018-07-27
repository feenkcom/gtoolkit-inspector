*GToolkit-Inspector
gtMetricsFor: aView
	<gtView: 0>
	^ aView 
		title: 'Metrics';
		stencil: [ BlMetricsInspector new relocate:25@25; for: self ]