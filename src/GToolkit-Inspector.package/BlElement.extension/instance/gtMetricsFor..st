*GToolkit-Inspector
gtMetricsFor: aView
	<gtView: 0>
	^ aView explicit
		title: 'Metrics';
		stencil: [ BlMetricsInspector new relocate:25@25; for: self ]