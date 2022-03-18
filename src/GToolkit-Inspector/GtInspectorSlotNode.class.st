Class {
	#name : #GtInspectorSlotNode,
	#superclass : #GtInspectorVariableNode,
	#instVars : [
		'slot'
	],
	#category : #'GToolkit-Inspector-Model'
}

{ #category : #'instance creation' }
GtInspectorSlotNode class >> hostObject: anObject slot: aSlot [
	^ (self hostObject: anObject)
		slot: aSlot;
		yourself
]

{ #category : #accessing }
GtInspectorSlotNode >> errorMessage [
	^ 'error obtaining attribute value'
]

{ #category : #accessing }
GtInspectorSlotNode >> key [
	^ self slot name
]

{ #category : #accessing }
GtInspectorSlotNode >> rawValue [
	^ self hostObject readSlot: slot
]

{ #category : #actions }
GtInspectorSlotNode >> save: anObject [
	self hostObject writeSlot: self slot value: anObject
]

{ #category : #accessing }
GtInspectorSlotNode >> slot [
	^ slot
]

{ #category : #accessing }
GtInspectorSlotNode >> slot: aSlot [

	self
		assert: [ aSlot isNotNil ]
		description: [ 'Slot can not be nil' ].

	slot := aSlot.
]

{ #category : #accessing }
GtInspectorSlotNode >> variableTag [
	^ 'attribute'
]
