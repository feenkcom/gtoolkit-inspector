*GToolkit-Inspector
gtMetricsFor: aView
	<gtView>
	^ aView explicit
		title: 'Metrics';
		priority: 20;
		stencil: [ BlMetricsInspector new relocate:25@25; for: self ]