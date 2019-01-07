Extension { #name : #MemoryLogger }

{ #category : #'*GToolkit-Inspector' }
MemoryLogger >> gtGroupedFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Grouped';
		items: [ (self recordings reverse groupedBy: [ :each | each class ]) associations ];
		column: 'Class' do: [ :aColumn |
			aColumn
				item: [ :each | BlTextElement new width: 200; text: each key asRopedText ];
				matchParent ];
		column: 'Instances' do: [ :aColumn |
			aColumn
				item: [ :each | BlTextElement new width: 200; text: each value size asString asRopedText ];
				matchParent ]
]

{ #category : #'*GToolkit-Inspector' }
MemoryLogger >> gtRecordingsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Recordings' translated;
		priority: 50;
		items: [ self recordings reverse ];
		column: 'Timestamp' translated do: [ :aColumn | 
			aColumn 
				item: [ :each | each timestamp asString ]; 
				matchParent ];
		column: 'Process' translated do: [ :aColumn | 
			aColumn 
				item: [ :each | each processId asString ]; 
				matchParent ];
		column: 'Type' translated do: [ :aColumn | 
			aColumn 
				item: [ :each | each name ]; 
				matchParent ];
		column: 'Contents' translated do: [ :aColumn | 
			aColumn 
				item: [ :each | String streamContents: [ :s | each printOneLineContentsOn: s ] ]; 
				matchParent ]
]
