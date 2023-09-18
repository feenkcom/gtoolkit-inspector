Extension { #name : #MCSnapshot }

{ #category : #'*GToolkit-Inspector' }
MCSnapshot >> gtViewDefinitionsFor: aView [
	<gtView>
	^ aView list
		title: 'Definitions';
		priority: 10;
		items: [ self definitions ]
]

{ #category : #'*GToolkit-Inspector' }
MCSnapshot >> gtViewDefinitionsGroupedByTypeFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Definitions by type';
		priority: 20;
		items: [ 
			(self definitions  
				groupedBy: [ :aDefinition |
					aDefinition class ]) associations ];
		column: 'Type' text: [ :assoc | assoc key ];
		column: 'Count' text: [ :assoc | assoc value ];
		send: [ :assoc | assoc value ] 
]
