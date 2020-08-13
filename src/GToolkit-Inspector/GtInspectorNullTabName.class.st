Class {
	#name : #GtInspectorNullTabName,
	#superclass : #GtInspectorAbstractTabName,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit-Inspector-Tab Selector'
}

{ #category : #testing }
GtInspectorNullTabName >> hasTabName [
	^ false
]

{ #category : #testing }
GtInspectorNullTabName >> isEqualToString: aString [
	^ false
]

{ #category : #printing }
GtInspectorNullTabName >> printOn: aStream [
	aStream nextPutAll: 'Without tab name'
]
