Class {
	#name : #GtInspectorVariableNode,
	#superclass : #Object,
	#instVars : [
		'hostObject'
	],
	#category : #'GToolkit-Inspector-Model'
}

{ #category : #'instance creation' }
GtInspectorVariableNode class >> hostObject: anObject [ 
	^ self new
		hostObject: anObject;
		yourself
]

{ #category : #composition }
GtInspectorVariableNode >> childrenNodes [
	"Return a collection of subvariable nodes to be displayed in a given raw variables browser."
	<return: #Collection of: #GtInspectorVariableNode>
	| variableNodes |
	
	variableNodes := OrderedCollection new: self value class allSlots size.
	variableNodes add: (GtInspectorSelfNode hostObject: self value).
	self value gtInspectorVariableNodesIn: variableNodes.
	
	^ variableNodes
]

{ #category : #accessing }
GtInspectorVariableNode >> errorMessage [
	^ 'error obtaining value'
]

{ #category : #accessing }
GtInspectorVariableNode >> hostObject [
	^ hostObject
]

{ #category : #accessing }
GtInspectorVariableNode >> hostObject: anObject [

	"
	Allow nil objects for the moment. Normally the inspector should be able to inspect nil.
	self
		assert: [ anObject isNotNil ]
		description: [ 'Host object must not be nil' ]."

	self
		assert: [ hostObject isNil ]
		description: [ 'Host can be assigned only once' ].

	hostObject := anObject
]

{ #category : #accessing }
GtInspectorVariableNode >> key [
	"Answer the key of this object variable (slot, indexed attribute, computed value)."
	^ self subclassResponsibility
]

{ #category : #accessing }
GtInspectorVariableNode >> label [
	"Answer the label of this object variable (slot, indexed attribute, computed value)."
	^ self key asString
]

{ #category : #accessing }
GtInspectorVariableNode >> rawValue [
	"Answer the object value of this object variable (slot, indexed attribute, computed value)."
	^ self subclassResponsibility
]

{ #category : #actions }
GtInspectorVariableNode >> save: aValue [
]

{ #category : #accessing }
GtInspectorVariableNode >> value [
	"Answer the object value of this object variable (slot, indexed attribute, computed value).
	Return nil in case there is an error obtaining the value"
	^ [ self rawValue ] on: Error do: [ nil ]
]

{ #category : #accessing }
GtInspectorVariableNode >> variableTag [
	^ 'implicit'
]
