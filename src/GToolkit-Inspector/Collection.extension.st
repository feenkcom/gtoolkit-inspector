Extension { #name : #Collection }

{ #category : #'*GToolkit-Inspector' }
Collection >> gtItemsFor: aView [
	<gtView>
	| aList |

	aList := aView columnedList
		title: 'Items' translated;
		priority: 50;
		items: [ self asOrderedCollection ].
		
	aList column
		title: 'Item' translated;
		matchParent;
		item: [ :eachItem :eachIndex | eachItem ].
	
	^ aList
]
