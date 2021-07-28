Extension { #name : #BlEventDispatcherChain }

{ #category : #'*GToolkit-Inspector' }
BlEventDispatcherChain >> gtDispatchersFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Dispatchers';
		items: [ self withAllPrevious reversed select: #hasDispatcher thenCollect: #dispatcher ];
		column: 'Dispatcher' item: #yourself;
		column: 'Type' item: #type
]
