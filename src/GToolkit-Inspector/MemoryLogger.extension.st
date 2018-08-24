Extension { #name : #MemoryLogger }

{ #category : #'*GToolkit-Inspector' }
MemoryLogger >> gtGroupedFor: aView [
	<gtView>
	^ aView explicit
		title: 'Grouped';
		stencil: [ 
			| list |
			list := BrColumnedList new display: (self recordings reverse groupedBy: [ :each | each class ]) associations.
			list addEventHandler: (GtInspectorListToSelectHandler new transformation: [ :association | association value ]).
			list constraintsDo: [ :c | c padding: (BlInsets top: 10) ].
			list column
				title: 'Class';
				stencil: [ :each | BlTextElement new width: 200; text: each key asRopedText ].
			list column 
				title: 'Instances';
				stencil: [ :each | BlTextElement new width: 200; text: each value size asString asRopedText ].
			list ]
]

{ #category : #'*GToolkit-Inspector' }
MemoryLogger >> gtRecordingsFor: aView [
	<gtView: 0>
	^ aView explicit
		title: 'Recordings';
		stencil: [ 
			| list |
			list := BrColumnedList new display: self recordings reverse.
			list addEventHandler: (GtInspectorListToSelectHandler new transformation: [ :association | association value ]).
			list constraintsDo: [ :c | c padding: (BlInsets top: 10) ].
			list column
				title: 'Timestamp';
				stencil: [ :each | BlTextElement new width: 200; text: each timestamp asString asRopedText ].
			list column 
				title: 'Process';
				stencil: [ :each | BlTextElement new width: 200; text: each processId asString asRopedText ].
			list column
				title: 'Type';
				stencil: [ :each | BlTextElement new width: 200; text: each name asRopedText ].
			list column
				title: 'Contents';
				stencil: [ :each | 
					BlTextElement new text: (String streamContents: [ :s | each printOneLineContentsOn: s ]) asRopedText ].
			list ]
]
