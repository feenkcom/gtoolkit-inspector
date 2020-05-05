Class {
	#name : #Gt2InspectorProtoTabName,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Inspector-! New - Tab Selector'
}

{ #category : #testing }
Gt2InspectorProtoTabName >> isEqualToString: aString [
	<return: #Boolean>
	^ self subclassResponsibility
]
