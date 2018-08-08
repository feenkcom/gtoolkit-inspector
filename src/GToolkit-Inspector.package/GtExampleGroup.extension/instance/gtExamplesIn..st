*GToolkit-Inspector
gtExamplesIn: aView
	<gtView: 30>
	^ aView
		title: 'Examples';
		stencil: [ | theExamples aList |
			theExamples := self examples.
			aList := BrColumnedList new display: theExamples.
			aList column
				title: 'Icon' translated;
				stencil: [ :eachExample :anIndex | 
					(BrImageStencil new image: eachExample icon) asElement
						constraintsDo: [ :c | 
							c horizontal exact: 15.
							c vertical exact: 20.
							c padding: (BlInsets top: 2) ];
						when: BlClickEvent do: [ :anEvent | 
							anEvent consumed: true.
							aList selectOne: anIndex ] ].
			aList column
				title: 'Result' translated;
				stencil: [ :eachExample :anIndex | 
					(BrListLabelStencil fitContent: eachExample resultOrErrorName) asElement
						constraintsDo: [ :c |  
							c padding: (BlInsets left: 10) ];
						when: BlClickEvent do: [ :anEvent  |
							anEvent consumed: true.
							aList selectOne: anIndex ] ].
			aList column
				title: 'Selector' translated;
				stencil: [ :eachExample :anIndex | 
					(BrListLabelStencil matchParent: 
							eachExample example selector asString, ' (', 
							eachExample example methodClass name ,')' ) asElement
						constraintsDo: [ :c |  
							c padding: (BlInsets left: 10) ];
						when: BlClickEvent do: [ :anEvent  |
							anEvent consumed: true.
							aList selectOne: anIndex ] ].
			aList 
				when: BrSelectionChanged do: [ :anEvent | 
					anEvent selectedDo: [ :anInterval | 
					aList fireEvent: (GLMBlocObjectToSelect new 
						toSelect: (aList viewModel items at: (aList selection from))) ] ]
			]