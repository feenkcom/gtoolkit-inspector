Class {
	#name : #GtInspectorObject,
	#superclass : #GtInspectorAbstractObject,
	#instVars : [
		'object',
		'hasObject',
		'viewSelector',
		'context'
	],
	#category : #'GToolkit-Inspector-Model'
}

{ #category : #factory }
GtInspectorObject class >> null [ 
	^ GtInspectorNullObject default
]

{ #category : #converting }
GtInspectorObject >> asElementDo: aOneArgBlock [
	"Create an element representing an object and execute the block"
	self view asElementDo: aOneArgBlock
]

{ #category : #asserting }
GtInspectorObject >> assertObjectImmutability [
	self 
		assert: [ hasObject not ]
		description: [ 'Object holder is immutable. The object cannot be changed.' ].
]

{ #category : #asserting }
GtInspectorObject >> assertViewSelectorImmutability [
	self 
		assert: [ self viewSelector = self defaultViewSelector ]
		description: [ 'Object holder is immutable. The view selector cannot be changed.' ].
]

{ #category : #actions }
GtInspectorObject >> clearCachedData [
	"Give subclasses a hook to clear any cached data when the holder is reused"
]

{ #category : #configuring }
GtInspectorObject >> configurePageViewModel: aPageViewModel [
	"Configuration to be applied to the page view model for the current object"
]

{ #category : #accessing }
GtInspectorObject >> context [
	<return: #GtPhlowContext>
	^ context ifNil: [ context := GtPhlowContext new ]
]

{ #category : #accessing }
GtInspectorObject >> context: anObject [
	context := anObject
]

{ #category : #defaults }
GtInspectorObject >> defaultViewSelector [
	^ #gtViewsFor:inContext:
]

{ #category : #initialization }
GtInspectorObject >> initialize [
	super initialize.
	hasObject := false.
	viewSelector := self defaultViewSelector
]

{ #category : #accessing }
GtInspectorObject >> object [
	^ object
]

{ #category : #accessing }
GtInspectorObject >> object: anObject [
	self assertObjectImmutability.
	object := anObject.
	hasObject := true.
]

{ #category : #printing }
GtInspectorObject >> printOn: aStream [
	aStream 
		nextPutAll: 'Holder of ';
		print: self object
]

{ #category : #accessing }
GtInspectorObject >> view [
	"Answer the view for the receiver's object and view"

	"Using #object:perform:withArguments:inClass: allows proxies that are a subclass of ProtoObject to be inspected. #perform:with: is defined in Object."

	<return: #GtPhlowLabelledView>
	
	^ GtPhlowView empty 
		on: self object 
		perform: self viewSelector
		withContext: self context.
]

{ #category : #accessing }
GtInspectorObject >> viewSelector [
	<return: #Symbol>
	^ viewSelector
]

{ #category : #accessing }
GtInspectorObject >> viewSelector: aSymbol [
	self assertViewSelectorImmutability.
	self 
		assert: [ aSymbol isSymbol ] 
		description: [ 'View selector must be a symbol' ].
	viewSelector := aSymbol asSymbol 
]
