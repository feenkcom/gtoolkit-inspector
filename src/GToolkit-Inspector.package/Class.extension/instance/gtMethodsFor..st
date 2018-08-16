*GToolkit-Inspector
gtMethodsFor: aView
	<gtView: 21>
	^ aView 
		title: 'Methods' translated;
		stencil: [
			| list |
			list := BrColumnedList new display: [ (self methods collect: #asRingDefinition) 
						sorted: [ :x :y | x selector < y selector ] ].
			list column 
				title: 'Selector';
				stencil: [ :each :rowIndex | (BrListLabelStencil matchParent: each selector) asElement
					when: BlClickEvent do: [ :anEvent |
						anEvent consumed: true.
						list selectOne: rowIndex ] ].
			list column 
				title: 'Class';
				stencil: [ :each :rowIndex  | (BrListLabelStencil fitContent: each methodClass name) asElement
					when: BlMouseDownEvent do: [ :anEvent |
						anEvent consumed: true.
						list selectOne: rowIndex ] ].
			list when: BrSelectionChanged do: [ :aSelectionEvent |
				aSelectionEvent selectedDo: [ :anInterval |
					| aSelectedObject |
					aSelectedObject := list viewModel items at: anInterval last.
					aSelectionEvent currentTarget fireEvent: (GtPhlowObjectToSpawn new
						object: aSelectedObject;
						sourceElement: aSelectionEvent currentTarget) ] ] ]