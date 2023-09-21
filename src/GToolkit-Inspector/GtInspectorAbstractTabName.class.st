Class {
	#name : #GtInspectorAbstractTabName,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : 'GToolkit-Inspector-Tab Selector'
}

{ #category : #testing }
GtInspectorAbstractTabName >> hasTabName [
	^ true
]

{ #category : #testing }
GtInspectorAbstractTabName >> isEqualToString: aString [
	<return: #Boolean>
	^ self subclassResponsibility
]
