Extension { #name : #Collection }

{ #category : #'*GToolkit-Inspector' }
Collection >> gtItemsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Items' translated;
		priority: 50;
		items: [ self asOrderedCollection ];
		column: 'Item' text: [ :eachItem | eachItem gtDisplayText ];
		actionUpdateButtonTooltip: 'Update item list'
]
