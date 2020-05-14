Class {
	#name : #GtInspectorUpdatePhlowViewTask,
	#superclass : #GtInspectorTask,
	#instVars : [
		'compiledMethod'
	],
	#category : #'GToolkit-Inspector-System Observer'
}

{ #category : #comparing }
GtInspectorUpdatePhlowViewTask >> = anObject [
	^ super = anObject
		and: [ self selector = anObject selector ]
]

{ #category : #accessing }
GtInspectorUpdatePhlowViewTask >> compiledMethod [
	^ compiledMethod
]

{ #category : #accessing }
GtInspectorUpdatePhlowViewTask >> compiledMethod: anObject [
	compiledMethod := anObject
]

{ #category : #execution }
GtInspectorUpdatePhlowViewTask >> execute [
	self newUpdater update
]

{ #category : #comparing }
GtInspectorUpdatePhlowViewTask >> hash [
	^ super hash bitXor: self selector hash
]

{ #category : #'instance creation' }
GtInspectorUpdatePhlowViewTask >> newUpdater [
	^ GtInspectorTabUpdater new
		inspectorInstance: self inspectorInstance;
		viewMethodDefinition: self compiledMethod asRingDefinition
]

{ #category : #convenience }
GtInspectorUpdatePhlowViewTask >> selector [
	^ self compiledMethod ifNotNil: #selector
]
