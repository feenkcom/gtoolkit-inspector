*GToolkit-Inspector
gtBinaryContentsFor: aView
	<gtView>
	self hasEntity ifFalse: [ ^ aView empty ].
	self contentType isBinary ifFalse: [ ^ aView empty ].
	^ ((Dictionary new at: 'entity' put: self entity; yourself)
		gtItemsFor: aView)
			title: 'Contents';
			priority: 40