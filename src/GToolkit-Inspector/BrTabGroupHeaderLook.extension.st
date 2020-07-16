Extension { #name : #BrTabGroupHeaderLook }

{ #category : #'*GToolkit-Inspector' }
BrTabGroupHeaderLook >> gtTabsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Tabs';
		items: [ self tabs ];
		column: 'Model' item: #key
]
