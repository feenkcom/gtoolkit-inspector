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
ZnManagingMultiThreadedServer >> gtOpenLocalUrlFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousIcons go asElement;
		tooltip: 'Open in Web Browser';
		priority: 12;
		action: [ WebBrowser openOn: self localUrl]
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
		{ 'local url' . self localUrl }.
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
		updateWhen: ZnServerStartedEvent in: [ ZnLogEvent announcer ];
		updateWhen: ZnServerStoppedEvent in: [ ZnLogEvent announcer ];
		actionUpdateButton;
		column: 'Key' text: #first;
		column: 'Value' text: #second weight: 5;
		send: #last
]

{ #category : #'*GToolkit-Inspector' }
ZnManagingMultiThreadedServer >> gtStartActionFor: anAction [
	<gtAction>
	"self isRunning ifTrue: [ ^ anAction noAction ]."
	^ anAction button
		icon: BrGlamorousVectorIcons play;
		tooltip: 'Start HTTP server';
		priority: 10;
		action: [ self start ]
]

{ #category : #'*GToolkit-Inspector' }
ZnManagingMultiThreadedServer >> gtStopActionFor: anAction [
	<gtAction>
	"self isRunning ifFalse: [ ^ anAction noAction ]."
	^ anAction button
		icon: BrGlamorousVectorIcons shutdown;
		tooltip: 'Stop HTTP server';
		priority: 11;
		action: [ self stop ]
]
