Extension { #name : 'BrTabGroup' }

{ #category : '*GToolkit-Inspector' }
BrTabGroup >> gtTabsFor: aView [
	<gtView>
	self viewModel ifNil: [ ^ aView empty ].
	^ aView columnedList 
		title: 'Tabs';
		priority: 3;
		items: [ self viewModel tabs ];
		column: 'Name' text: #yourself;
		column: 'Selection' text: #isSelected width: 80;
		actionUpdateButtonTooltip: 'Update tab list'
]
