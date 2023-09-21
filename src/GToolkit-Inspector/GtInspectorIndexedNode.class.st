Class {
	#name : #GtInspectorIndexedNode,
	#superclass : #GtInspectorVariableNode,
	#instVars : [
		'index'
	],
	#category : #'GToolkit-Inspector-Model'
}

{ #category : #'instance creation' }
GtInspectorIndexedNode class >> hostObject: anObject index: index [
	^ (self hostObject: anObject)
		index: index;
		yourself
]

{ #category : #accessing }
GtInspectorIndexedNode >> errorMessage [
	^ 'error obtaining indexed attribute value'
]

{ #category : #accessing }
GtInspectorIndexedNode >> index [
	^ index
]

{ #category : #accessing }
GtInspectorIndexedNode >> index: anInteger [
	index := anInteger
]

{ #category : #accessing }
GtInspectorIndexedNode >> key [
	^ self index
]

{ #category : #accessing }
GtInspectorIndexedNode >> rawValue [
	^ self hostObject basicAt: index
]

{ #category : #actions }
GtInspectorIndexedNode >> save: aValue [
	self hostObject at: self index put: aValue
]

{ #category : #accessing }
GtInspectorIndexedNode >> variableTag [
	^ 'attribute'
]
