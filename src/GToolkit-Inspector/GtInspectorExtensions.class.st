Class {
	#name : #GtInspectorExtensions,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'collection'
	],
	#category : #'GToolkit-Inspector-! New - Model'
}

{ #category : #factory }
GtInspectorExtensions class >> autoInitialized [
	^ GtInspectorAutoInitializedExtensions new
]

{ #category : #factory }
GtInspectorExtensions class >> default [
	^ self autoInitialized
]

{ #category : #adding }
GtInspectorExtensions >> addExtension: aGtInspectorExtension [
	self assertExtension: aGtInspectorExtension.
	self collection: (self collection copyWith: aGtInspectorExtension).
]

{ #category : #notifications }
GtInspectorExtensions >> addedToSceneGraph [
	"Notification that the inspector was added to a scene graph"
	self collection do: #addedToSceneGraph
]

{ #category : #asserting }
GtInspectorExtensions >> assertCollection: anArray [
	self 
		assert: [ anArray isCollection ] 
		description: [ 'Extension collection must be a collection' ].
]

{ #category : #asserting }
GtInspectorExtensions >> assertExtension: aGtInspectorExtension [
	self 
		assert: [ aGtInspectorExtension isNotNil ] 
		description: [ 'Extension must be non-nil' ].
]

{ #category : #accessing }
GtInspectorExtensions >> collection [
	<return: #Array>
	^ collection
]

{ #category : #accessing }
GtInspectorExtensions >> collection: anArray [
	self assertCollection: anArray.
	collection := anArray
]

{ #category : #defaults }
GtInspectorExtensions >> defaultCollection [
	^ Array empty
]

{ #category : #'gt-extensions' }
GtInspectorExtensions >> gtExtensionsFor: aView [
	<gtView>
	self collection ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Extensions';
		items: [ self collection ];
		addUpdateButton
]

{ #category : #initialization }
GtInspectorExtensions >> initialize [
	super initialize.
	self initializeCollection
]

{ #category : #initialization }
GtInspectorExtensions >> initializeCollection [
	collection := self defaultCollection.
]

{ #category : #accessing }
GtInspectorExtensions >> inspectorInstance: anInspector [
	"Set the attached inspector instance"
	self collection do: [ :eachExtension | 
		eachExtension inspectorInstance: anInspector ]
]

{ #category : #notifications }
GtInspectorExtensions >> objectChangedTo: anObject [
	self collection do: [ :eachExtension | 
		eachExtension objectChangedTo: anObject ]
]

{ #category : #notifications }
GtInspectorExtensions >> objectRemoved [
	self collection do: #objectRemoved
]

{ #category : #notifications }
GtInspectorExtensions >> removedFromSceneGraph [
	"Notification that the inspector was removed from a scene graph"
	self collection do: #removedFromSceneGraph
]
