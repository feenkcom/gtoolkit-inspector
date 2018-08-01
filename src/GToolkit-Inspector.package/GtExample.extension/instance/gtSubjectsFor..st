*GToolkit-Inspector
gtSubjectsFor: aView
	<gtView: 4>
	self hasSubjects ifFalse: [ ^ aView empty ].
	^ (self subjects gtItemsFor: aView)
			title: 'Subjects'