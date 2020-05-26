Class {
	#name : #GtInspectorTool,
	#superclass : #GtPhlowTool,
	#traits : 'TGtInspectorObjectAccess',
	#classTraits : 'TGtInspectorObjectAccess classTrait',
	#category : #'GToolkit-Inspector-Phlow Tool'
}

{ #category : #accessing }
GtInspectorTool class >> priority [
	<return: #Number>
	^ 1
]

{ #category : #converting }
GtInspectorTool >> asElementDo: aOneArgBlock [
	"Create a tool element and execute the block"
	| anInspector |
	anInspector := GtInspector new 
		objectHolder: self objectHolder.
	aOneArgBlock cull: anInspector asPagerPageElement.
]

{ #category : #accessing }
GtInspectorTool >> object [
	"compatibility method for ${GLMBlocObjectToSelect}$"
	^ self objectHolder object
]

{ #category : #accessing }
GtInspectorTool >> object: anObject [
	"Store object that is going to be inspected"
	| anObjectHolder |
	anObjectHolder := GtInspectorObject new object: anObject.
	self objectHolder: anObjectHolder.
]
