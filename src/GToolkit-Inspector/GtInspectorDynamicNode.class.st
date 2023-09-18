Class {
	#name : #GtInspectorDynamicNode,
	#superclass : #GtInspectorVariableNode,
	#instVars : [
		'label',
		'value',
		'tag'
	],
	#category : #'GToolkit-Inspector-Model'
}

{ #category : #'instance creation' }
GtInspectorDynamicNode class >> hostObject: anObject label: aString value: anotherObject [
	^ (self hostObject: anObject) 
		label: aString;
		rawValue: anotherObject;
		yourself
]

{ #category : #accessing }
GtInspectorDynamicNode >> key [
	^ label
]

{ #category : #accessing }
GtInspectorDynamicNode >> label [
	^ label
]

{ #category : #accessing }
GtInspectorDynamicNode >> label: aString [
	label := aString
]

{ #category : #accessing }
GtInspectorDynamicNode >> rawValue [
	^ value
]

{ #category : #accessing }
GtInspectorDynamicNode >> rawValue: anObject [
	value := anObject
]

{ #category : #accessing }
GtInspectorDynamicNode >> variableTag [
	^  tag ifNil: [ super variableTag ]
]

{ #category : #accessing }
GtInspectorDynamicNode >> variableTag: aTag [
	tag := aTag
]
