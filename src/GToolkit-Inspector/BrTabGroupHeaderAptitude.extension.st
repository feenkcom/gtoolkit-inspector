Extension { #name : #BrTabGroupHeaderAptitude }

{ #category : #'*GToolkit-Inspector' }
BrTabGroupHeaderAptitude >> gtTabsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Tabs';
		items: [ self tabs ];
		column: 'Model' text: #key
]
