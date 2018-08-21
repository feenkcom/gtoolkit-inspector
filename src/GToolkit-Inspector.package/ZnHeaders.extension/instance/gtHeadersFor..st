*GToolkit-Inspector
gtHeadersFor: aView
	<gtView>
	^ (self headers gtItemsFor: aView)
			title: (self headers size asString, ' items');
			priority: 30