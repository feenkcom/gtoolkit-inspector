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
GtInspectorVariableNode >> childrenNodesFor: aVariablesBrowser [
	"Return a collection of subvariable nodes to be displayed in a given raw variables browser.
	Note: by default we dispatch to browser and let it perform collection"
	<return: #Collection of: #GtInspectorVariableNode>

	^ aVariablesBrowser childrenVariableNodesForNode: self
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
