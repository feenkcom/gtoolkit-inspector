Extension { #name : 'BrTabGroup' }

{ #category : '*GToolkit-Inspector' }
BrTabGroup >> gtTabsFor: aView [
	<gtView>
	self viewModel ifNil: [ ^ aView empty ].
	^ aView columnedList 
		title: 'Tabs';
		priority: 3;
		items: [ self viewModel tabs ];
		column: 'Name' item: #yourself;
		column: 'Selection' item: #isSelected width: 80;
		actionUpdateButtonTooltip: 'Update tab list'
]
