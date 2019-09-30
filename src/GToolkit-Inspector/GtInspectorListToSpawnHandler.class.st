Class {
	#name : #GtInspectorListToSpawnHandler,
	#superclass : #GtInspectorListHandler,
	#category : #'GToolkit-Inspector-Brick'
}

{ #category : #accessing }
GtInspectorListToSpawnHandler >> eventClass [
	^ BrSelectionChanged
]

{ #category : #'api - event managing' }
GtInspectorListToSpawnHandler >> handleEvent: anEvent [
	| aWidgetElement |
	
	aWidgetElement := anEvent currentTarget.
	
	anEvent selectedDo: [ :anInterval |
		| selectedObject |
		selectedObject := aWidgetElement viewModel itemAt: anInterval first.
		aWidgetElement fireEvent: (GtPhlowObjectToSpawn new 
			object: (self transformedValueFrom: selectedObject);
			sourceElement: aWidgetElement).
		aWidgetElement fireEvent: (GLMBlocObjectToSelect new 
			toSelect: (self transformedValueFrom: selectedObject)) ]
]
