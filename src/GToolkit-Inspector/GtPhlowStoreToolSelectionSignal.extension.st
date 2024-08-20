Extension { #name : #GtPhlowStoreToolSelectionSignal }

{ #category : #'*GToolkit-Inspector' }
GtPhlowStoreToolSelectionSignal >> gtOverview [
	^ {GtPhlowOverviewItem new
			name: 'Selection state';
			value: self selectionState.
		GtPhlowOverviewItem new
			name: 'Phlow view';
			value: self phlowView.
		GtPhlowOverviewItem new
			name: 'Tool element';
			value: self toolElement}
]

{ #category : #'*GToolkit-Inspector' }
GtPhlowStoreToolSelectionSignal >> gtOverviewFor: aView [
	<gtView>
	selectionState ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Overview';
		priority: 0;
		items: [ self gtOverview ];
		column: 'Name' text: #name weight: 0.3;
		column: 'Value' text: #description;
		send: #value
]
