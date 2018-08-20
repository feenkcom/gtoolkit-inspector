*GToolkit-Inspector
gtTextContentsFor: aView
	<gtView>
	self hasEntity ifFalse: [ ^ aView empty ].
	self contentType isBinary ifTrue: [ ^ aView empty ].
	^ (self contents gtStringFor: aView)
		title: 'Contents';
		priority: 40