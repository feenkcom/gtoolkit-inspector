*GToolkit-Inspector
gtLiveFor: aView
	<gtView: -1>
	^ aView explicit
		title: 'Live';
		stencil: [ self ]