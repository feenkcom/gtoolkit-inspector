Extension { #name : #ZnManagingMultiThreadedServer }

{ #category : #'*GToolkit-Inspector' }
ZnManagingMultiThreadedServer >> gtClientConnectionsFor: aView [
	<gtView>
	^ aView list 
		title: 'Connections';
		items: [ self connections ];
		actionUpdateButtonTooltip: 'Update connection list';
		actionButtonIcon: BrGlamorousIcons trash 
			tooltip: 'Close all connections' 
			action: [ :aButton :aTab | self closeConnections ]
]

{ #category : #'*GToolkit-Inspector' }
ZnManagingMultiThreadedServer >> gtOptionsFor: aView [
	<gtView>
	^ aView forward 
		title: 'Options';
		priority: 50;
		object: [ | allBindings |
			allBindings := self localOptions allBindings.
			(((GtSearchInheritedMethodsFilter forClass: ZnManagingMultiThreadedServer)
					withSuperclassesUpTo: ZnServer)
				& (#optionAt:ifAbsent: gtReferences | #optionAt:ifAbsentPut: gtReferences)) contents 
					do: [ :each | | selector |
						selector := each selector.
						selector numArgs isZero ifTrue: [ 
							allBindings at: selector put: (self perform: selector) ] ].
			OrderedDictionary withAll: (allBindings associations sort: #key ascending) ];
		view: #gtTreeFor:
]

{ #category : #'*GToolkit-Inspector' }
ZnManagingMultiThreadedServer >> gtOverview [
	^ {
		{ 'running' . self isRunning . process }.
		{ 'listening' . self isListening . serverSocket }.
		{ 'port' . self port }.
		{ 'delegate' . self delegate }.
		{ 'log level' . logLevel }
	}
]

{ #category : #'*GToolkit-Inspector' }
ZnManagingMultiThreadedServer >> gtOverviewFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Overview';
		priority: 40;
		items: [ self gtOverview ];
		actionUpdateButtonTooltip: 'Update overview';
		column: 'Name' text: #first;
		column: 'Value' text: #second weight: 5;
		send: #last
]
