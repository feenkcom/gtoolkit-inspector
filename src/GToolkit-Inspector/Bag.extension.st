Extension { #name : #Bag }

{ #category : #'*GToolkit-Inspector' }
Bag >> gtOccurrencesFor: aView [
	<gtView>
	self valuesAndCounts ifNil: [ ^ aView empty ].
	self valuesAndCounts ifEmpty: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Occurrences';
		items: [ self sortedCounts ];
		column: 'Item' item: [ :anAssoc | anAssoc value ];
		column: 'Occurrences' item: [ :anAssoc | anAssoc key ];
		send: [ :anAssoc | anAssoc value ]
]
