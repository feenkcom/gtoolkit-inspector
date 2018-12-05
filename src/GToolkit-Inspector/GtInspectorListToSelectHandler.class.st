Class {
	#name : #GtInspectorListToSelectHandler,
	#superclass : #GtInspectorListHandler,
	#category : #'GToolkit-Inspector-Brick'
}

{ #category : #accessing }
GtInspectorListToSelectHandler >> eventClass [
	^ BrSelectionChanged
]

{ #category : #accessing }
GtInspectorListToSelectHandler >> eventClasses [
	^ { BrSelectionChanged . BrSelectionDoubleClicked }
]

{ #category : #'api - event managing' }
GtInspectorListToSelectHandler >> handleEvent: anEvent [
	anEvent acceptInspectorHandler: self
]

{ #category : #'api - event managing' }
GtInspectorListToSelectHandler >> selectionChangedEvent: anEvent [
	| listElement |

	listElement := anEvent currentTarget.
	anEvent asBeaconSignal emit.

	anEvent selectedDo: [ :anInterval |
		| selectedObject |
		selectedObject := listElement viewModel items at: listElement selection from.
		listElement fireEvent: (GtPhlowObjectToSelect new 
			object: (self transformedValueFrom: selectedObject);
			sourceElement: listElement).
		listElement fireEvent: (GLMBlocObjectToSelect new toSelect: (self transformedValueFrom: selectedObject)) ]
]

{ #category : #'api - event managing' }
GtInspectorListToSelectHandler >> selectionDoubleClickedEvent: anEvent [
	| listElement selectedObject |
	
	listElement := anEvent currentTarget.
	
	selectedObject := listElement viewModel items at: listElement selection from.
	listElement fireEvent: (GtPhlowObjectToSpawn new 
		object: (self transformedValueFrom: selectedObject);
		sourceElement: listElement).
	listElement fireEvent: (GLMBlocObjectToSelect new 
		toSelect: (self transformedValueFrom: selectedObject))
]

{ #category : #'api - event managing' }
GtInspectorListToSelectHandler >> wantsEvent: anEvent [
	^ self eventClasses includes: anEvent class
]
