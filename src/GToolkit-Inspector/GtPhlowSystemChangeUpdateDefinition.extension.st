Extension { #name : #GtPhlowSystemChangeUpdateDefinition }

{ #category : #'*GToolkit-Inspector' }
GtPhlowSystemChangeUpdateDefinition >> gtElementContextFor: aView [
	<gtView>
	self contexts ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Contexts';
		items: [ self contexts ];
		column: 'Element' item: #element;
		column: 'View' item: #entity
]
