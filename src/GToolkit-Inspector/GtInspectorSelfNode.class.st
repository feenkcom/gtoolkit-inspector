Class {
	#name : #GtInspectorSelfNode,
	#superclass : #GtInspectorVariableNode,
	#category : #'GToolkit-Inspector-Model'
}

{ #category : #composition }
GtInspectorSelfNode >> childrenNodesFor: aVariablesBrowser [
	"Self node does not have any subvariables, just return empty collection"
	<return: #Collection of: #GtInspectorVariableNode>

	^ #()
]

{ #category : #accessing }
GtInspectorSelfNode >> key [
	^ 'self'
]

{ #category : #accessing }
GtInspectorSelfNode >> rawValue [
	^ self hostObject
]
