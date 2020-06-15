Extension { #name : #BrTabGroupHeaderLook }

{ #category : #'*GToolkit-Inspector' }
BrTabGroupHeaderLook >> gtTabsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Tabs';
		items: [ self tabs ];
		column: 'Model' do: [ :aColumn | 
			aColumn 
				item: [ :anAssoc | anAssoc key ];
				matchParent ]
]
