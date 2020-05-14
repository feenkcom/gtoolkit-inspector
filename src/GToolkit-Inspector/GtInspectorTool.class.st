Class {
	#name : #GtInspectorTool,
	#superclass : #GtPhlowTool,
	#category : #'GToolkit-Inspector-Phlow Tool'
}

{ #category : #accessing }
GtInspectorTool class >> priority [
	<return: #Number>
	^ 1
]

{ #category : #converting }
GtInspectorTool >> asElementDo: aOneArgBlock context: aContext [
	"Create a tool element and execute the block"
	| anInspector |
	anInspector := GtInspector newWrapperOn: aContext object.
	aOneArgBlock cull: anInspector asElement.
]
