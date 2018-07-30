*GToolkit-Inspector
gtImplementorsFor: aView
	<gtView: 4>
	| result |
	result := self compiledMethod implementors gtItemsFor: aView.
	^ result title: 'Implementors'.
