Class {
	#name : #GtInspectorTabIdentifier,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Inspector-Tab Selector'
}

{ #category : #testing }
GtInspectorTabIdentifier >> matchesTab: aTabModel [
	<return: #Boolean>
	^ self subclassResponsibility
]
