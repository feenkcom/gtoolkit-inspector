api - event managing
selectionDoubleClickedEvent: anEvent
	| listElement selectedObject |
	
	listElement := anEvent currentTarget.
	
	selectedObject := listElement viewModel items at: listElement selection from.
	listElement fireEvent: (GtPhlowObjectToSpawn new 
		object: (self transformedValueFrom: selectedObject);
		sourceElement: listElement).
	listElement fireEvent: (GLMBlocObjectToSelect new 
		toSelect: (self transformedValueFrom: selectedObject))