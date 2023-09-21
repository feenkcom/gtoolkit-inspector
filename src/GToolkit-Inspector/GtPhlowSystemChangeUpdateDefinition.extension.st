Extension { #name : #GtPhlowSystemChangeUpdateDefinition }

{ #category : #'*GToolkit-Inspector' }
GtPhlowSystemChangeUpdateDefinition >> gtElementContextFor: aView [
	<gtView>
	self contexts ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Contexts';
		items: [ self contexts ];
		column: 'Element' text: #element;
		column: 'View' text: #entity;
		actionUpdateButtonTooltip: 'Update context list'
]
