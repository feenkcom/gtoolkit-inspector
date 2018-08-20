*GToolkit-Inspector
gtGroupedFor: aView
	<gtView>
	^ aView explicit
		title: 'Grouped';
		stencil: [ 
			| list |
			list := BrColumnedList new display: (self recordings reverse groupedBy: [ :each | each class ]) associations.
			list addEventHandler: (GtInspectorListToSelectHandler new transformation: [ :association | association value ]).
			list column
				title: 'Class';
				stencil: [ :each | BlTextElement new width: 200; text: each key asRopedText ].
			list column 
				title: 'Instances';
				stencil: [ :each | BlTextElement new width: 200; text: each value size asString asRopedText ].
			list ]