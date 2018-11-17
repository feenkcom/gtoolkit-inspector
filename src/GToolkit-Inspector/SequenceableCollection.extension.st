Extension { #name : #SequenceableCollection }

{ #category : #'*GToolkit-Inspector' }
SequenceableCollection >> gtItemsFor: aView [
	<gtView>
	| aList |

	aList := aView columnedList
		title: 'Items' translated;
		priority: 50;
		items: [ self asOrderedCollection ].

	aList column
		title: 'Index' translated;
		width: 30;
		evaluated: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray].
	
	aList column
		title: 'Item' translated;
		evaluated: [ :eachItem :eachIndex | eachItem ].
	
	^ aList
]
