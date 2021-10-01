Extension { #name : #Bag }

{ #category : #'*GToolkit-Inspector' }
Bag >> gtOccurrencesFor: aView [
	<gtView>
	self valuesAndCounts ifNil: [ ^ aView empty ].
	self valuesAndCounts ifEmpty: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Occurrences';
		items: [ self sortedCounts ];
		column: 'Item' text: [ :anAssoc | anAssoc value ];
		column: 'Occurrences' text: [ :anAssoc | anAssoc key ];
		send: [ :anAssoc | anAssoc value ]
]
