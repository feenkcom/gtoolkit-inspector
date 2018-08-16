api - event managing
handleEvent: anEvent
	| listElement |

	listElement := anEvent currentTarget.

	listElement fireEvent: (GtInspectorObjectToSelect new object: anEvent rowValue).
	listElement fireEvent: (GLMBlocObjectToSelect new toSelect: anEvent rowValue)