Class {
	#name : #GtInspectorProtoObjectNode,
	#superclass : #GtInspectorVariableNode,
	#instVars : [
		'index',
		'slotName'
	],
	#category : #'GToolkit-Inspector-Model'
}

{ #category : #'instance creation' }
GtInspectorProtoObjectNode class >> hostObject: anObject index: index slotName: aSlotName [
	^ (self hostObject: anObject)
		index: index slotName: aSlotName;
		yourself
]

{ #category : #accessing }
GtInspectorProtoObjectNode >> index: anIndex slotName: aSlotName [
	index := anIndex.
	slotName := aSlotName.
]

{ #category : #accessing }
GtInspectorProtoObjectNode >> key [
	^ slotName
]

{ #category : #accessing }
GtInspectorProtoObjectNode >> rawValue [ 
	^ thisContext object: self hostObject instVarAt: index 
]

{ #category : #accessing }
GtInspectorProtoObjectNode >> variableTag [
	^ 'attribute'
]
