Class {
	#name : #Gt2InspectorTool,
	#superclass : #GtPhlowTool,
	#category : #'GToolkit-Inspector-! New - Tool'
}

{ #category : #accessing }
Gt2InspectorTool class >> priority [
	<return: #Number>
	^ 1
]

{ #category : #converting }
Gt2InspectorTool >> asElementDo: aOneArgBlock context: aContext [
	"Create a tool element and execute the block"
	| anInspector |
	anInspector := Gt2Inspector newWrapperOn: aContext object.
	aOneArgBlock cull: anInspector asElement.
]
