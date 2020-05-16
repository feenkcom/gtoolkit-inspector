Class {
	#name : #GtInspectorListToSpawnHandler,
	#superclass : #GtInspectorListHandler,
	#category : #'GToolkit-Inspector-Convenience and Utilities'
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
		aWidgetElement phlow spawnObject: 
			(self transformedValueFrom: selectedObject selection: anInterval).
		aWidgetElement fireEvent: (GLMBlocObjectToSelect new 
			toSelect: (self transformedValueFrom: selectedObject selection: anInterval)) ]
]
