Extension { #name : #BlDirectEventDispatcher }

{ #category : #'*GToolkit-Inspector' }
BlDirectEventDispatcher >> gtFiltersFor: aView [
	<gtView>

	filters
		ifNil: [ ^ aView empty ].

	^ (filters gtHandlersFor: aView)
			title: 'Filters'
]

{ #category : #'*GToolkit-Inspector' }
BlDirectEventDispatcher >> gtHandlersFor: aView [
	<gtView>
	
	handlers
		ifNil: [ ^ aView empty ].
	
	^ (handlers gtHandlersFor: aView)
			title: 'Handlers'
]

{ #category : #'*GToolkit-Inspector' }
BlDirectEventDispatcher >> gtOwnerElementFor: aView [
	<gtView>
	self owner ifNil: [ ^ aView empty ].
	^ aView forward 
		title: 'Owner element';
		priority: 55;
		object: [ self owner ];
		view: #gtPreviewFor:
]
