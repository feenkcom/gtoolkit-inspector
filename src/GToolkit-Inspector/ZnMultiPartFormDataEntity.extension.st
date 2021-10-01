Extension { #name : #ZnMultiPartFormDataEntity }

{ #category : #'*GToolkit-Inspector' }
ZnMultiPartFormDataEntity >> gtViewMimePartsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Mime Parts';
		items: [ self parts ];
		column: 'Name' text: [ :aMinePart | aMinePart fieldName ];
		column: 'Entity' text: [ :aMinePart | aMinePart entity ]
]
