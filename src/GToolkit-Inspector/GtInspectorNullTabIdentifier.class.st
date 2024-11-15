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

{ #category : #printing }
GtInspectorNullTabIdentifier >> descriptionOn: aStream [
	aStream nextPutAll: 'Null identifier'
]

{ #category : #testing }
GtInspectorNullTabIdentifier >> matchesTab: aTabModel [
	^ false
]

{ #category : #printing }
GtInspectorNullTabIdentifier >> printOn: aStream [
	self descriptionOn: aStream
]
