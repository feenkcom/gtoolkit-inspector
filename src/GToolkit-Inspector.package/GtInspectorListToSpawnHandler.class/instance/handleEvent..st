api - event managing
handleEvent: anEvent
	| listElement |
	
	listElement := anEvent currentTarget.
	
	anEvent selectedDo: [ :anInterval |
		listElement fireEvent: (GtInspectorObjectToSpawn new object: (listElement viewModel items at: (listElement selection from)); sourceElement: listElement).
		listElement fireEvent: (GLMBlocObjectToSelect new toSelect: (listElement viewModel items at: (listElement selection from))) ]