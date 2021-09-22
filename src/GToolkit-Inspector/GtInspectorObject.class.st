Class {
	#name : 'GtInspectorObject',
	#superclass : 'GtInspectorAbstractObject',
	#instVars : [
		'object',
		'hasObject',
		'viewSelector'
	],
	#category : 'GToolkit-Inspector-Model'
}

{ #category : 'factory' }
GtInspectorObject class >> null [ 
	^ GtInspectorNullObject default
]

{ #category : 'converting' }
GtInspectorObject >> asElementDo: aOneArgBlock [
	"Create an element representing an object and execute the block"
	self view asElementDo: aOneArgBlock
]

{ #category : 'asserting' }
GtInspectorObject >> assertObjectImmutability [
	self 
		assert: [ hasObject not ]
		description: [ 'Object holder is immutable. The object cannot be changed.' ].
]

{ #category : 'asserting' }
GtInspectorObject >> assertViewSelectorImmutability [
	self 
		assert: [ self viewSelector = self defaultViewSelector ]
		description: [ 'Object holder is immutable. The view selector cannot be changed.' ].
]

{ #category : 'defaults' }
GtInspectorObject >> defaultViewSelector [
	^ #gtViewsFor:
]

{ #category : 'initialization' }
GtInspectorObject >> initialize [
	super initialize.
	hasObject := false.
	viewSelector := self defaultViewSelector
]

{ #category : 'notifying' }
GtInspectorObject >> notifyObjectChangedIn: anInspector [
	anInspector notifyObjectChangedTo: self object.
]

{ #category : 'accessing' }
GtInspectorObject >> object [
	^ object
]

{ #category : 'accessing' }
GtInspectorObject >> object: anObject [
	self assertObjectImmutability.
	object := anObject.
	hasObject := true.
]

{ #category : 'printing' }
GtInspectorObject >> printOn: aStream [
	aStream 
		nextPutAll: 'Holder of ';
		print: self object
]

{ #category : 'accessing' }
GtInspectorObject >> view [
	"Answer the view for the receiver's object and view"
	<return: #GtPhlowLabelledView>

	"Using #object:perform:withArguments:inClass: allows proxies that are a subclass of ProtoObject to be inspected. #perform:with: is defined in Object."
	^ thisContext
		object: self object
		perform: self viewSelector
		withArguments: { GtPhlowView empty }
		inClass: self object class.

]

{ #category : 'accessing' }
GtInspectorObject >> viewSelector [
	<return: #Symbol>
	^ viewSelector
]

{ #category : 'accessing' }
GtInspectorObject >> viewSelector: aSymbol [
	self assertViewSelectorImmutability.
	self 
		assert: [ aSymbol isSymbol ] 
		description: [ 'View selector must be a symbol' ].
	viewSelector := aSymbol asSymbol 
]
