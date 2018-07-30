*GToolkit-Inspector
gtSendersFor: aView
	<gtView: 4>
	| result |
	result := self compiledMethod senders gtItemsFor: aView.
	^ result title: 'Senders'.
