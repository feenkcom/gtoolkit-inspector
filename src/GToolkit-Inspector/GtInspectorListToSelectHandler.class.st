Class {
	#name : #GtInspectorListToSelectHandler,
	#superclass : #GtInspectorListHandler,
	#category : #'GToolkit-Inspector-Brick'
}

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
	| aWidgetElement |

	aWidgetElement := anEvent currentTarget.
	anEvent asBeaconSignal emit.

	anEvent selectedDo: [ :anInterval |
		| selectedObject |

		selectedObject := aWidgetElement viewModel itemAt: anInterval first.
		aWidgetElement fireEvent: (GtPhlowObjectToSelect new 
			object: (self transformedValueFrom: selectedObject selection: anEvent selection);
			sourceElement: aWidgetElement).
		aWidgetElement fireEvent: (GLMBlocObjectToSelect new toSelect: (self transformedValueFrom: selectedObject selection: anEvent selection)) ]
]

{ #category : #'api - event managing' }
GtInspectorListToSelectHandler >> selectionDoubleClickedEvent: anEvent [
	| aWidgetElement selectedObject |
	
	aWidgetElement := anEvent currentTarget.
	
	selectedObject := aWidgetElement viewModel itemAt: anEvent selection from.
	aWidgetElement fireEvent: (GtPhlowObjectToSpawn new 
		object: (self transformedValueFrom: selectedObject selection: anEvent selection);
		sourceElement: aWidgetElement).
	aWidgetElement fireEvent: (GLMBlocObjectToSelect new 
		toSelect: (self transformedValueFrom: selectedObject selection: anEvent selection))
]

{ #category : #'api - event managing' }
GtInspectorListToSelectHandler >> wantsEvent: anEvent [
	^ self eventClasses includes: anEvent class
]
