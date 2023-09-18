Class {
	#name : #GtInspectorWrapperNode,
	#superclass : #GtInspectorVariableNode,
	#instVars : [
		'label'
	],
	#category : #'GToolkit-Inspector-Model'
}

{ #category : #'instance creation' }
GtInspectorWrapperNode class >> hostObject: anObject label: aString [
	^ (self hostObject: anObject) 
		label: aString;
		yourself
]

{ #category : #composition }
GtInspectorWrapperNode >> childrenNodes [
	^ self hostObject childrenNodes
]

{ #category : #accessing }
GtInspectorWrapperNode >> errorMessage [
	^ self hostObject errorMessage
]

{ #category : #accessing }
GtInspectorWrapperNode >> inspectorActionsForNode [
	^ self hostObject inspectorActionsForNode
]

{ #category : #accessing }
GtInspectorWrapperNode >> key [
	^ label ifNil: [ self hostObject key ]
]

{ #category : #accessing }
GtInspectorWrapperNode >> label: aString [
	label := aString
]

{ #category : #accessing }
GtInspectorWrapperNode >> rawValue [
	^ self hostObject rawValue
]

{ #category : #accessing }
GtInspectorWrapperNode >> variableTag [
	^ self hostObject variableTag
]
