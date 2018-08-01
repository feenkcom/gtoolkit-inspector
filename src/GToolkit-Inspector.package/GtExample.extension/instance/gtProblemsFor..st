*GToolkit-Inspector
gtProblemsFor: aView
	<gtView: 5>
	self hasProblems ifFalse: [ ^ aView empty ].
	^ (self problems gtItemsFor: aView)
			title: 'Problems'