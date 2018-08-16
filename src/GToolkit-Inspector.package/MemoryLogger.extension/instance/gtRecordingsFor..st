*GToolkit-Inspector
gtRecordingsFor: aView
	<gtView: 0>
	^ aView explicit
		title: 'Recordings';
		stencil: [ 
			| list |
			list := BrColumnedList new display: self recordings reverse.
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