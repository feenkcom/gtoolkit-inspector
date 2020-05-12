Class {
	#name : #Gt2InspectorExtensions,
	#superclass : #Gt2InspectorProtoModelExtensions,
	#instVars : [
		'collection'
	],
	#category : #'GToolkit-Inspector-! New - Model'
}

{ #category : #factory }
Gt2InspectorExtensions class >> autoInitialized [
	^ Gt2InspectorAutoInitializedExtensions new
]

{ #category : #factory }
Gt2InspectorExtensions class >> default [
	^ self autoInitialized
]

{ #category : #adding }
Gt2InspectorExtensions >> addExtension: aGtInspectorExtension [
	self assertExtension: aGtInspectorExtension.
	self collection: (self collection copyWith: aGtInspectorExtension).
]

{ #category : #asserting }
Gt2InspectorExtensions >> assertCollection: anArray [
	self 
		assert: [ anArray isCollection ] 
		description: [ 'Extension collection must be a collection' ].
]

{ #category : #asserting }
Gt2InspectorExtensions >> assertExtension: aGtInspectorExtension [
	self 
		assert: [ aGtInspectorExtension isNotNil ] 
		description: [ 'Extension must be non-nil' ].
]

{ #category : #accessing }
Gt2InspectorExtensions >> collection [
	<return: #Array>
	^ collection
]

{ #category : #accessing }
Gt2InspectorExtensions >> collection: anArray [
	self assertCollection: anArray.
	collection := anArray
]

{ #category : #defaults }
Gt2InspectorExtensions >> defaultCollection [
	^ Array empty
]

{ #category : #ui }
Gt2InspectorExtensions >> gtExtensionsFor: aView [
	<gtView>
	self collection ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Extensions';
		items: [ self collection ]
]

{ #category : #initialization }
Gt2InspectorExtensions >> initialize [
	super initialize.
	self initializeCollection
]

{ #category : #initialization }
Gt2InspectorExtensions >> initializeCollection [
	collection := self defaultCollection.
]

{ #category : #factory }
Gt2InspectorExtensions >> null [
	^ Gt2InspectorNullExtensions default
]

{ #category : #notifications }
Gt2InspectorExtensions >> objectChangedTo: anObject [
	self collection do: [ :each |  		each objectChangedTo: anObject ]
]

{ #category : #notifications }
Gt2InspectorExtensions >> objectRemoved [
	self collection objectRemoved
]
