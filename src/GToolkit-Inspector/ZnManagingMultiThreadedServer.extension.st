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
ZnManagingMultiThreadedServer >> gtOverview [
	^ OrderedCollection new 
		add: ('listening' -> self isListening);
		add: ('port' -> self port);
		add: ('delegate' -> self delegate);
		yourself
		
]

{ #category : #'*GToolkit-Inspector' }
ZnManagingMultiThreadedServer >> gtOverviewFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Overview';
		items: [ self gtOverview ];
		actionUpdateButtonTooltip: 'Update overview';
		column: 'Name' text: #key;
		column: 'Value' text: #value weight: 2;
		send: #value
]
