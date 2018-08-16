api - event managing
handleEvent: anEvent
	| listElement |
	
	listElement := anEvent currentTarget.
	
	anEvent selectedDo: [ :anInterval |
		listElement fireEvent: (GtPhlowObjectToSpawn new 
			object: (self transformation value: (listElement viewModel items at: listElement selection from));
			sourceElement: listElement).
		listElement fireEvent: (GLMBlocObjectToSelect new 
			toSelect: (self transformation value: (listElement viewModel items at: listElement selection from))) ]