Class {
	#name : #GtInspectorListToSelectHandler,
	#superclass : #GtInspectorListHandler,
	#category : #'GToolkit-Inspector-Convenience and Utilities'
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
			object: (self transformedValueFrom: selectedObject selection: anInterval);
			sourceElement: aWidgetElement).
		aWidgetElement fireEvent: (GLMBlocObjectToSelect new toSelect: (self transformedValueFrom: selectedObject selection: anInterval)) ]
]

{ #category : #'api - event managing' }
GtInspectorListToSelectHandler >> selectionDoubleClickedEvent: anEvent [
	
	anEvent selection
		ifNotEmpty: [ :theIndices |
			| aWidgetElement selectedObject |
	
			aWidgetElement := anEvent currentTarget.
			
			selectedObject := aWidgetElement viewModel itemAt: theIndices first.
			aWidgetElement fireEvent: (GtPhlowObjectToSpawn new 
				object: (self transformedValueFrom: selectedObject selection: theIndices);
				sourceElement: aWidgetElement).
			aWidgetElement fireEvent: (GLMBlocObjectToSelect new 
				toSelect: (self transformedValueFrom: selectedObject selection: theIndices)) ]
]

{ #category : #'api - event managing' }
GtInspectorListToSelectHandler >> wantsEvent: anEvent [
	^ self eventClasses includes: anEvent class
]
