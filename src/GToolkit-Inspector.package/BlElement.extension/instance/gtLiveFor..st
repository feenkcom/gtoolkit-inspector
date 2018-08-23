*GToolkit-Inspector
gtLiveFor: aView
	<gtView>
	^ aView explicit
		title: 'Live';
		priority: 0;
		stencil: [ self ]