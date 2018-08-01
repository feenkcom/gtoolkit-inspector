*GToolkit-Inspector
gtAfterFor: aView
	<gtView: 3>
	self hasAfter ifFalse: [ ^ aView empty ].
	^ ({ self after } gtItemsFor: aView)
			title: 'After'