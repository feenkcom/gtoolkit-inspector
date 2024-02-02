Class {
	#name : #GtInspectorNullTabIdentifier,
	#superclass : #GtInspectorTabIdentifier,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit-Inspector-Tab Selector'
}

{ #category : #accessing }
GtInspectorNullTabIdentifier >> applySelectionTo: anInspectorElement [
]

{ #category : #testing }
GtInspectorNullTabIdentifier >> matchesTab: aTabModel [
	^ false
]

{ #category : #printing }
GtInspectorNullTabIdentifier >> printOn: aStream [
	aStream nextPutAll: 'Null identifier'
]
