*GToolkit-Inspector
gtChangesFor: aView
	<gtView>
	^ (self changes gtItemsFor: aView) 
		title: 'Changes';
		priority: 30