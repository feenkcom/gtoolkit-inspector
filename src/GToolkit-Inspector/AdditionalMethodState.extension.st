Extension { #name : #AdditionalMethodState }

{ #category : #'*GToolkit-Inspector' }
AdditionalMethodState >> gtPropertiesFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Properties';
		priority: 1;
		items: [ self properties associations ];
		column: 'Property' text: #key;
		column: 'Value' text: #value;
		actionUpdateButton;
		send: #value
]
