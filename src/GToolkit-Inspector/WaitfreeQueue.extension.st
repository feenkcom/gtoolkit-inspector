Extension { #name : #WaitfreeQueue }

{ #category : #'*GToolkit-Inspector' }
WaitfreeQueue >> gtItemsFor: aView [
	<gtView> 
	| aList |

	aList := aView columnedList
		title: 'Items' translated;
		priority: 50;
		items: [ self itemArray ].

	aList column
		title: 'Index' translated;
		width: 30;
		item: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray].
	
	aList column
		title: 'Object' translated;
		item: [ :eachItem :eachIndex | 
			eachItem object == dummy ifTrue: [ '<Zombie>' ] ifFalse: [ eachItem object ] ];
		itemFormat: [ :eachItem | eachItem asString ].
	
	^ aList
]
