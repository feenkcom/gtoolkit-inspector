Class {
	#name : #GtInspectorTabIdentifier,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Inspector-Tab Selector'
}

{ #category : #printing }
GtInspectorTabIdentifier >> description [
	^ String streamContents: [ :aStream |
		self descriptionOn:  aStream ]
]

{ #category : #printing }
GtInspectorTabIdentifier >> descriptionOn: aStream [
]

{ #category : #testing }
GtInspectorTabIdentifier >> matchesTab: aTabModel [
	<return: #Boolean>
	^ self subclassResponsibility
]
