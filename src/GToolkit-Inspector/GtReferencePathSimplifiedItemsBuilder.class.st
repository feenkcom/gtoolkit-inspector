Class {
	#name : #GtReferencePathSimplifiedItemsBuilder,
	#superclass : #Object,
	#instVars : [
		'currentIndex',
		'referencedObjects',
		'currentReferencedObject'
	],
	#category : #'GToolkit-Inspector-Reference Path'
}

{ #category : #building }
GtReferencePathSimplifiedItemsBuilder >> build [
	| canditates canditate skip rest items |
	self referencedObjects ifNil: [ ^ #() ].
	self referencedObjects ifEmpty: [ ^ #() ].
	items := OrderedCollection new.

	currentIndex := 1.
	[ currentIndex <= self referencedObjects size ]
		whileTrue: [ currentReferencedObject := self referencedObjects at: currentIndex.

			canditates := self patterns
					select: [ :each | 
						currentIndex + (each skip value: self) - 1 <= self referencedObjects size
							and: [ each condition value: self ] ].
			canditate := canditates detectMax: [ :each | each skip value: self ].
			skip := canditate skip value: self.
			rest := skip = 1
					ifTrue: [ #() ]
					ifFalse: [ self referencedObjects copyFrom: currentIndex + 1 to: currentIndex + skip - 1 ].
			items
				add: (canditate item
						value: self
						value: currentReferencedObject
						value: rest).
			currentIndex := currentIndex + skip ].

	^ items
]

{ #category : #'api - accessing' }
GtReferencePathSimplifiedItemsBuilder >> currentObject [
	^ currentReferencedObject object
]

{ #category : #'api - accessing' }
GtReferencePathSimplifiedItemsBuilder >> currentReferencedObject [
	<return: #GtReferencedObject>
	^ currentReferencedObject
]

{ #category : #'api - accessing' }
GtReferencePathSimplifiedItemsBuilder >> followingObject [
	^ self followingObject: 1
]

{ #category : #'api - accessing' }
GtReferencePathSimplifiedItemsBuilder >> followingObject: anInteger [
	^ (self followingReferencedObject: anInteger) object
]

{ #category : #'api - accessing' }
GtReferencePathSimplifiedItemsBuilder >> followingReferencedObject [
	^ self followingReferencedObject: 1
]

{ #category : #'api - accessing' }
GtReferencePathSimplifiedItemsBuilder >> followingReferencedObject: anInteger [ 
	^ self referencedObjects at: currentIndex + anInteger
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
				name: ('{1}''s {2} class variable' format: {rest first object. rest last object name});
				referencedObject: rest first;
				skipped: (Array with: current withAll: rest allButFirst) ]
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

{ #category : #accessing }
GtReferencePathSimplifiedItemsBuilder >> referencedObjects [
	<return: #Collection of: #GtReferencedObject>
	^ referencedObjects
]

{ #category : #accessing }
GtReferencePathSimplifiedItemsBuilder >> referencedObjects: aCollectionOfReferencedObjects [
	referencedObjects := aCollectionOfReferencedObjects
]

{ #category : #patterns }
GtReferencePathSimplifiedItemsBuilder >> singleObject [
	<referencePathPattern>
	^ GtReferencePathPattern new
		condition: [ :builder | true ];
		skip: [ :builder | 1 ];
		item: [ :builder :current :rest | GtReferencePathObjectItem new referencedObject: current ]
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
				name: ('{1} globals' format: {current object});
				referencedObject: current;
				skipped: rest ]
]
