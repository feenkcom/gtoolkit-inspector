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

{ #category : #'api - patterns' }
GtReferencePathSimplifiedItemsBuilder >> all [
	^ GtReferencePathAllCondition new builder: self
]

{ #category : #'pattern definitions' }
GtReferencePathSimplifiedItemsBuilder >> blockDirectEventDispatcher [
	<referencePathPattern>
	^ GtReferencePathPattern new
		condition: [ :builder | 
			builder all
				current: [ :object | object isKindOf: BlDirectEventDispatcher ];
				following: [ :object | object isKindOf: BlHandlerAnnouncerRegistry ];
				following: [ :object | object isKindOf: Announcer ];
				following: [ :object | object isKindOf: SubscriptionRegistry ];
				following: [ :object | object isKindOf: IdentitySet ];
				following: [ :object | object isKindOf: Array ];
				following: [ :object | object isKindOf: BlHandlerAnnouncementSubscription ] ];
		item: [ :builder :current :all | 
			GtReferencePathShortItem new
				name: ('Subscription in {1}' format: {current object});
				referencedObject: current;
				all: all ]
]

{ #category : #building }
GtReferencePathSimplifiedItemsBuilder >> build [
	| results result shift all items |
	self referencedObjects ifNil: [ ^ #() ].
	self referencedObjects ifEmpty: [ ^ #() ].
	items := OrderedCollection new.

	currentIndex := 1.
	[ currentIndex <= self referencedObjects size ]
		whileTrue: [ currentReferencedObject := self referencedObjects at: currentIndex.

			results := self patterns
					collect: [ :each | (each condition value: self) item: each item ]
					thenSelect: [ :each | each conclusion ].
			result := results detectMax: [ :each | each shift ].
			shift := result shift.
			all := self referencedObjects
					copyFrom: currentIndex
					to: currentIndex + shift.
			items
				add: (result item
						value: self
						value: currentReferencedObject
						value: all).
			currentIndex := currentIndex + shift + 1 ].

	^ items
]

{ #category : #'pattern definitions' }
GtReferencePathSimplifiedItemsBuilder >> collectionWithArray [
	<referencePathPattern>
	^ GtReferencePathPattern new
		condition: [ :builder | 
			builder all
				current: [ :object | object isKindOf: Collection ];
				following: [ :object | object isKindOf: Array ] ];
		item: [ :builder :current :all | 
			GtReferencePathShortItem new
				name: ('{1}' format: {current object});
				referencedObject: current;
				all: all ]
]

{ #category : #'api - accessing' }
GtReferencePathSimplifiedItemsBuilder >> currentIndex [
	^ currentIndex
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

{ #category : #'pattern definitions' }
GtReferencePathSimplifiedItemsBuilder >> dictionaryWithArray [
	<referencePathPattern>
	^ GtReferencePathPattern new
		condition: [ :builder | 
			builder all
				current: [ :object | object isDictionary ];
				following: [ :object | object isKindOf: Array ];
				following: [ :object | object isKindOf: Association ] ];
		item: [ :builder :current :all | 
			GtReferencePathShortItem new
				name: ('{1}' format: {current object});
				referencedObject: current;
				all: all ]
]

{ #category : #'pattern definitions' }
GtReferencePathSimplifiedItemsBuilder >> doubleLinkList [
	<referencePathPattern>
	^ GtReferencePathPattern new
		condition: [ :builder | 
			builder all
				current: [ :object | object isKindOf: DoubleLinkedList ];
				following: [ :object | object isKindOf: DoubleLink ];
				allFollowing: [ :object | object isKindOf: DoubleLink ] ];
		item: [ :builder :current :all | 
			GtReferencePathShortItem new
				name: ('{1}' format: {current object});
				referencedObject: current;
				all: all ]
]

{ #category : #'pattern definitions' }
GtReferencePathSimplifiedItemsBuilder >> elementActor [
	<referencePathPattern>
	^ GtReferencePathPattern new
		condition: [ :builder | 
			builder all
				current: [ :object | object isDictionary ];
				current: [ :object :condition | 
					condition
						previousObject: 1
						is: [ :previous | (previous isKindOf: BlElement) and: [ previous userData == object ] ] ];
				following: [ :object | object isKindOf: Array ];
				following: [ :object | object isKindOf: Association ];
				following: [ :object :condition | (object == condition previousObject key) not ];
				current: [ :object | object isKindOf: BrActor ];
				allFollowingSequences: {
					[ :object :condition | object isCollection ].
					[ :object | object isKindOf: BrActor ]} ];
		item: [ :builder :current :all | 
			GtReferencePathShortItem new
				name: ('{1}' format: {all last object});
				referencedObject: all last;
				all: all ]
]

{ #category : #'pattern definitions' }
GtReferencePathSimplifiedItemsBuilder >> elementChild [
	<referencePathPattern>
	^ GtReferencePathPattern new
		condition: [ :builder | 
			builder all
				current: [ :object | object isKindOf: BlElement ];
				following: [ :object | object isKindOf: BlChildrenCollection ];
				following: [ :object | object isCollection ];
				peek: [ :object | object isKindOf: BlElement ] ];
		item: [ :builder :current :all | 
			GtReferencePathShortItem new
				name: ('{1}' format: {current object});
				referencedObject: current;
				all: all ]
]

{ #category : #'pattern definitions' }
GtReferencePathSimplifiedItemsBuilder >> elementUserDataValue [
	<referencePathPattern>
	^ GtReferencePathPattern new
		condition: [ :builder | 
			builder all
				current: [ :object | object isDictionary ];
				current: [ :object :condition | 
					condition previousObjectIs: [ :previous | 
						(previous isKindOf: BlElement) and: [ previous userData == object ] ] ];
				following: [ :object | object isKindOf: Array ];
				following: [ :object | object isKindOf: Association ];
				following: [ :object :condition | (object == condition previousObject key) not ] ];
		item: [ :builder :current :all | 
			| key |
			key := (all detect: [ :each | each object isKindOf: Association ]) object key.
			GtReferencePathShortItem new
				name: ('User data at {1}: {2}'
						format: {key.
								all last value});
				referencedObject: all last;
				all: all ]
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

{ #category : #'pattern definitions' }
GtReferencePathSimplifiedItemsBuilder >> globalVariables [
	<referencePathPattern>
	^ GtReferencePathPattern new
		condition: [ :builder | 
			builder all
				current: [ :object | object isKindOf: GlobalVariable ];
				following: [ :object | object isClassOrTrait ];
				following: [ :object | object isDictionary ];
				following: [ :object | object class = Array ];
				following: [ :object | object isKindOf: ClassVariable ] ];
		item: [ :builder :current :all | 
			GtReferencePathShortItem new
				name: ('{1}''s {2} class variable'
						format: {all second object.
								all last object name});
				referencedObject: all second;
				all: all ]
]

{ #category : #views }
GtReferencePathSimplifiedItemsBuilder >> gtObjectsFor: aView [
	<gtView>
	referencedObjects ifNil: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Objects';
		items: [ referencedObjects ];
		children: [ :each | 
			(each isKindOf: GtReferencePathItem)
				ifTrue: [ each allReferencedObjects ]
				ifFalse: [ #() ] ];
		column: 'Type'
			text: [ :each | 
				each referenceTypeName asRopedText
					glamorousRegularSmallSize;
					foreground: Color gray ]
			width: 100;
		column: 'Value'
			textDo: [ :aColumn | 
				aColumn
					item: [ :each | each ];
					format: [ :each | 
						| aText |
						aText := each gtDisplayText.
						self currentReferencedObject == each ifTrue: [ aText bold ].
						aText ];
					background: [ :each | 
						each object = self targetObject object
							ifTrue: [ BrGlamorousColors successBackgroundColor ]
							ifFalse: [ Color transparent ] ] ];
		column: 'Class'
			text: [ :each | 
				each object class name asRopedText
					glamorousRegularSmallSize;
					foreground: Color gray ]
			width: 100;
		column: 'Package'
			text: [ :each | 
				each object class package name asRopedText
					glamorousRegularSmallSize;
					foreground: Color gray ]
			width: 100;
		send: #object;
		contextItemLabel: 'Spawn object'
			action: [ :element :node | element phlow spawnObject: node value object ];
		contextItemLabel: 'Spawn reference path item'
			action: [ :element :node | element phlow spawnObject: node value ]
]

{ #category : #'pattern definitions' }
GtReferencePathSimplifiedItemsBuilder >> parallelUniverseSpace [
	<referencePathPattern>
	^ GtReferencePathPattern new
		condition: [ :builder | 
			builder all
				current: [ :object | object == Smalltalk ];
				following: [ :object | object == Smalltalk globals ];
				following: [ :object | object == Smalltalk globals array ];
				following: [ :object | object isKindOf: GlobalVariable ];
				following: [ :object | object isClassOrTrait ];
				current: [ :object | object = BlParallelUniverse ];
				following: [ :object | object isDictionary ];
				following: [ :object | object class = Array ];
				following: [ :object | object isKindOf: ClassVariable ];
				following: [ :object | object isKindOf: Array ];
				following: [ :object | object isKindOf: BlParallelUniverse ];
				following: [ :object | object isKindOf: BlSpaceManager ];
				following: [ :object | object isKindOf: Array ];
				following: [ :object | object isKindOf: BlSpace ] ];
		item: [ :builder :current :all | 
			GtReferencePathShortItem new
				name: ('Universe''s {1}'
						format: {all last object});
				referencedObject: (all last);
				all: all ]
]

{ #category : #'api - patterns' }
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

{ #category : #'pattern definitions' }
GtReferencePathSimplifiedItemsBuilder >> singleObject [
	<referencePathPattern>
	^ GtReferencePathPattern new
		condition: [ :builder | 
			builder all current: [ :object | true ] ];
		item: [ :builder :current :all | 
			GtReferencePathObjectItem new referencedObject: current ]
]

{ #category : #'pattern definitions' }
GtReferencePathSimplifiedItemsBuilder >> smalltalkGlobals [
	<referencePathPattern>
	^ GtReferencePathPattern new
		condition: [ :builder | 
			builder all
				current: [ :object | object == Smalltalk ];
				following: [ :object | object == Smalltalk globals ];
				following: [ :object | object == Smalltalk globals array ] ];
		item: [ :builder :current :all | 
			GtReferencePathShortItem new
				name: ('{1} globals' format: {current object});
				referencedObject: current;
				all: all ]
]

{ #category : #'api - accessing' }
GtReferencePathSimplifiedItemsBuilder >> specificObject: anInteger [
	^ (self specificReferencedObject: anInteger) object
]

{ #category : #'api - accessing' }
GtReferencePathSimplifiedItemsBuilder >> specificReferencedObject: anInteger [
	^ self referencedObjects at: anInteger
]

{ #category : #'api - accessing' }
GtReferencePathSimplifiedItemsBuilder >> targetObject [
	<return: #GtReferencedObject>
	^ self referencedObjects last
]
