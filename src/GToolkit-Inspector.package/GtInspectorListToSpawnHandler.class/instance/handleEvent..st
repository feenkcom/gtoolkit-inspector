api - event managing
handleEvent: anEvent
	| listElement |
	
	listElement := anEvent currentTarget.
	
	anEvent selectedDo: [ :anInterval |
		| selectedObject |
		selectedObject := listElement viewModel items at: listElement selection from.
		listElement fireEvent: (GtPhlowObjectToSpawn new 
			object: (self transformedValueFrom: selectedObject);
			sourceElement: listElement).
		listElement fireEvent: (GLMBlocObjectToSelect new 
			toSelect: (self transformedValueFrom: selectedObject)) ]