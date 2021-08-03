Extension { #name : 'Array2D' }

{ #category : '*GToolkit-Inspector' }
Array2D >> gtTableFor: aView [
	<gtView>
	| view |

	(self numberOfRows isZero or: [ self numberOfColumns isZero ]) ifTrue: [ ^ aView empty ].
	view := aView columnedList 
		title: 'Table';
		priority: 10;
		items: [ self rowsCollect: [ :row | row ] ].
	1 to: self numberOfColumns do: [ :i |
		view column: i asString text: [ :item | item at: i ] ].
	^ view
]

{ #category : '*GToolkit-Inspector' }
Array2D >> rowsCollect: aBlock [ 
	"Collect the result of evaluating aBlock with each row of the receiver"

	^ Array streamContents: [ :stream |
		1 to: numberOfRows do: [ :row |
			stream nextPut: (aBlock value: (self atRow: row)) ] ]
]

{ #category : '*GToolkit-Inspector' }
Array2D >> rowsDo: aBlock [ 
	"Evaluate aBlock with each row of the receiver"

	1 to: numberOfRows do: [ :row |
		aBlock value: (self atRow: row) ]
]
