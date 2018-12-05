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
]
