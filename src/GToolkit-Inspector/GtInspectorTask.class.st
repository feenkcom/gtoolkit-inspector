Class {
	#name : #GtInspectorTask,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'inspectorInstance',
		'affectedClass'
	],
	#category : #'GToolkit-Inspector-! New - System Observer'
}

{ #category : #comparing }
GtInspectorTask >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class and: [ 
		self affectedClass = anObject affectedClass and: [ 
			self inspectorInstance = anObject inspectorInstance ] ]
]

{ #category : #accessing }
GtInspectorTask >> affectedClass [
	^ affectedClass
]

{ #category : #accessing }
GtInspectorTask >> affectedClass: anObject [
	affectedClass := anObject
]

{ #category : #converting }
GtInspectorTask >> asBlTktCommand [ 
	^ BlTktWrapperCommand new command: self
]

{ #category : #accessing }
GtInspectorTask >> entryIdentifier [
	^ self
]

{ #category : #execution }
GtInspectorTask >> execute [
	self subclassResponsibility
]

{ #category : #comparing }
GtInspectorTask >> hash [
	^ (self class hash 
		bitXor: self affectedClass hash)
			bitXor: self inspectorInstance
]

{ #category : #accessing }
GtInspectorTask >> inspectorInstance [
	<return: #GtInspecto>
	^ inspectorInstance
]

{ #category : #accessing }
GtInspectorTask >> inspectorInstance: aGtInspector [
	inspectorInstance := aGtInspector
]
