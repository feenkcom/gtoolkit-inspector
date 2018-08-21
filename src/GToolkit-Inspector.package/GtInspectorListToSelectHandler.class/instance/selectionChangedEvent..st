api - event managing
selectionChangedEvent: anEvent
	| listElement |

	listElement := anEvent currentTarget.
	anEvent asBeaconSignal emit.

	anEvent selectedDo: [ :anInterval |
		| selectedObject |
		selectedObject := listElement viewModel items at: listElement selection from.
		listElement fireEvent: (GtPhlowObjectToSelect new object: (self transformedValueFrom: selectedObject)).
		listElement fireEvent: (GLMBlocObjectToSelect new toSelect: (self transformedValueFrom: selectedObject)) ]