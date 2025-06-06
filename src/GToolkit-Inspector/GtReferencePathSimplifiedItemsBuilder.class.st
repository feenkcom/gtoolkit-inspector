Class {
	#name : #GtReferencePathSimplifiedItemsBuilder,
	#superclass : #Object,
	#instVars : [
		'objects',
		'currentIndex',
		'currentObject'
	],
	#category : #'GToolkit-Inspector-Reference Path'
}

{ #category : #building }
GtReferencePathSimplifiedItemsBuilder >> build [
	| canditates canditate skip rest items |
	self objects ifNil: [ ^ #() ].
	self objects ifEmpty: [ ^ #() ].
	items := OrderedCollection new.

	currentIndex := 1.
	[ currentIndex <= self objects size ]
		whileTrue: [ currentObject := self objects at: currentIndex.

			canditates := self patterns
					select: [ :each | 
						currentIndex + (each skip value: self) - 1 <= self objects size
							and: [ each condition value: self ] ].
			canditate := canditates detectMax: [ :each | each skip value: self ].
			skip := canditate skip value: self.
			rest := skip = 1
					ifTrue: [ #() ]
					ifFalse: [ self objects copyFrom: currentIndex + 1 to: currentIndex + skip - 1 ].
			items
				add: (canditate item
						value: self
						value: currentObject
						value: rest).
			currentIndex := currentIndex + skip ].

	^ items
]

{ #category : #'api - accessing' }
GtReferencePathSimplifiedItemsBuilder >> currentObject [
	^ currentObject
]

{ #category : #'api - accessing' }
GtReferencePathSimplifiedItemsBuilder >> followingObject [
	^ self followingObject: 1
]

{ #category : #'as yet unclassified' }
GtReferencePathSimplifiedItemsBuilder >> followingObject: anInteger [ 
	^ self objects at: currentIndex + anInteger
]

{ #category : #patterns }
GtReferencePathSimplifiedItemsBuilder >> globalVariables [
	<referencePathPattern>
	^ GtReferencePathPattern new
		condition: [ :builder | 
			(builder currentObject isKindOf: GlobalVariable)
				and: [ builder followingObject isClassOrTrait
						and: [ (builder followingObject: 2) isDictionary
								and: [ (builder followingObject: 3) class = Array
										and: [ (builder followingObject: 4) isKindOf: ClassVariable ] ] ] ] ];
		skip: [ :builder | 5 ];
		item: [ :builder :current :rest | 
			GtReferencePathShortItem new
				name: ('{1}''s {2} class variable' format: {rest first. rest last name});
				object: rest first;
				skipped: (Array with: current withAll: rest allButFirst) ]
]

{ #category : #patterns }
GtReferencePathSimplifiedItemsBuilder >> normalObject [
	<referencePathPattern>
	^ GtReferencePathPattern new
		condition: [ :pattern | true ];
		skip: [ :pattern | 1 ];
		item: [ :pattern :current :rest | GtReferencePathObjectItem new object: current ]
]

{ #category : #accessing }
GtReferencePathSimplifiedItemsBuilder >> objects [
	^ objects
]

{ #category : #accessing }
GtReferencePathSimplifiedItemsBuilder >> objects: aCollectionOfObjects [
	objects := aCollectionOfObjects
]

{ #category : #patterns }
GtReferencePathSimplifiedItemsBuilder >> patterns [
	| pragmas |
	pragmas := Pragma
			allNamed: #referencePathPattern
			from: self class
			to: GtReferencePathSimplifiedItemsBuilder.

	^ pragmas collect: [ :each | self perform: each methodSelector ]
]

{ #category : #patterns }
GtReferencePathSimplifiedItemsBuilder >> smalltalkGlobals [
	<referencePathPattern>
	^ GtReferencePathPattern new
		condition: [ :builder | 
			builder currentObject == Smalltalk
				and: [ builder followingObject == Smalltalk globals
						and: [ (builder followingObject: 2) == Smalltalk globals array ] ] ];
		skip: [ :builder | 3 ];
		item: [ :builder :current :rest | 
			GtReferencePathShortItem new
				name: ('{1} globals' format: {current});
				object: current;
				skipped: rest ]
]
