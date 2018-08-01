*GToolkit-Inspector
gtDependenciesFor: aView
	<gtView: 1>
	^ self directDependencies 
		ifEmpty: [ aView empty ] 
		ifNotEmpty: [ :aCollection | 
			(aCollection asOrderedCollection gtItemsFor: aView)
				title: 'Dependencies' ]
	
	