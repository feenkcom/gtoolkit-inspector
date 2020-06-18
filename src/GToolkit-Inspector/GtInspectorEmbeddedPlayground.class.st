Class {
	#name : #GtInspectorEmbeddedPlayground,
	#superclass : #GtInspectorExtension,
	#instVars : [
		'object',
		'playBook'
	],
	#category : #'GToolkit-Inspector-Model'
}

{ #category : #notifications }
GtInspectorEmbeddedPlayground >> addedToSceneGraph [
	"do nothing"
]

{ #category : #'widget configuration' }
GtInspectorEmbeddedPlayground >> fillToolWidgetIn: aCreationContext [
	GEmbeddedPlaygroundStencil new
		receiver: self object;
		asChildIn: aCreationContext contentElement
]

{ #category : #accessing }
GtInspectorEmbeddedPlayground >> inspectorInstance: anInspector [
	self object: anInspector object
]

{ #category : #accessing }
GtInspectorEmbeddedPlayground >> object [
	^ object
]

{ #category : #accessing }
GtInspectorEmbeddedPlayground >> object: anObject [
	object := anObject.
	self onObjectChanged.
]

{ #category : #notifications }
GtInspectorEmbeddedPlayground >> objectChangedTo: anObject [
	self object: anObject
]

{ #category : #notifications }
GtInspectorEmbeddedPlayground >> objectRemoved [
	self object: nil
]

{ #category : #hooks }
GtInspectorEmbeddedPlayground >> onObjectChanged [
	playBook ifNil: [ ^ self ].
	playBook receiver: self object.
]

{ #category : #notifications }
GtInspectorEmbeddedPlayground >> removedFromSceneGraph [
	"do nothing"
]
