*GToolkit-Inspector
gtUserDataFor: aView
	<gtView>
	^ (self userData gtItemsFor: aView) 
		title: 'User data';
		priority: 5