*GToolkit-Inspector
gtProblemsFor: aView
	<gtView>
	self hasProblems ifFalse: [ ^ aView empty ].
	^ (self problems gtItemsFor: aView)
			title: 'Problems'