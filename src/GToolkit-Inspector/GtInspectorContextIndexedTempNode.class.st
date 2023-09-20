Class {
	#name : #GtInspectorContextIndexedTempNode,
	#superclass : #GtInspectorVariableNode,
	#instVars : [
		'tempIndex'
	],
	#category : #'GToolkit-Inspector-Model'
}

{ #category : #'instance creation' }
GtInspectorContextIndexedTempNode class >> hostObject: aContext tempIndex: anInteger [
	^ (self hostObject: aContext) 
		tempIndex: anInteger;
		yourself
]

{ #category : #accessing }
GtInspectorContextIndexedTempNode >> label [
	^ self tempIndex
]

{ #category : #accessing }
GtInspectorContextIndexedTempNode >> rawValue [
	^ self hostObject at: self tempIndex
]

{ #category : #accessing }
GtInspectorContextIndexedTempNode >> tempIndex [
	^ tempIndex
]

{ #category : #accessing }
GtInspectorContextIndexedTempNode >> tempIndex: anObject [
	tempIndex := anObject
]

{ #category : #accessing }
GtInspectorContextIndexedTempNode >> variableTag [
	^  'temp' 
]
