Extension { #name : #BlDirectEventDispatcher }

{ #category : #'*GToolkit-Inspector' }
BlDirectEventDispatcher >> gtFiltersFor: aView [
	<gtView>
	filters ifNil: [ ^ aView empty ].
	^ (filters gtHandlersFor: aView)
			title: 'Filters' translated
]

{ #category : #'*GToolkit-Inspector' }
BlDirectEventDispatcher >> gtHandlersFor: aView [
	<gtView>
	handlers ifNil: [ ^ aView empty ].
	^ (handlers gtHandlersFor: aView)
			title: 'Handlers' translated
]
