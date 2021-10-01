Extension { #name : #BlEventDispatcherChain }

{ #category : #'*GToolkit-Inspector' }
BlEventDispatcherChain >> gtDispatchersFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Dispatchers';
		items: [ self withAllPrevious reversed select: #hasDispatcher thenCollect: #dispatcher ];
		column: 'Dispatcher' text: #yourself;
		column: 'Type' text: #type
]
