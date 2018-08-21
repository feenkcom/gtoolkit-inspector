*GToolkit-Inspector
gtAfterFor: aView
	<gtView>
	self hasAfter ifFalse: [ ^ aView empty ].
	^ ({ self after } gtItemsFor: aView)
			title: 'After'