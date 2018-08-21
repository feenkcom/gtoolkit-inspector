*GToolkit-Inspector
gtDependenciesFor: aView
	"<gtView>"
	^ self directDependencies 
		ifEmpty: [ aView empty ] 
		ifNotEmpty: [ :aCollection | 
			(aCollection asOrderedCollection gtItemsFor: aView)
				title: 'Dependencies' ]
	
	