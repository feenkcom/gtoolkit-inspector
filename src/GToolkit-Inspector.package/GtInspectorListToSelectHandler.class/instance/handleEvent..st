api - event managing
handleEvent: anEvent
	| listElement |

	listElement := anEvent currentTarget.

	anEvent selectedDo: [ :anInterval |
		listElement fireEvent: (GtInspectorObjectToSelect new object: (listElement viewModel items at: (listElement selection from))).
		listElement fireEvent: (GLMBlocObjectToSelect new toSelect: (listElement viewModel items at: (listElement selection from))) ]