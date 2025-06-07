Class {
	#name : #GtReferencePath,
	#superclass : #Object,
	#instVars : [
		'items'
	],
	#category : #'GToolkit-Inspector-Reference Path'
}

{ #category : #'instance creation' }
GtReferencePath class >> items: aCollectionOfReferencePathItem [
	^ self new items: aCollectionOfReferencePathItem
]

{ #category : #'instance creation' }
GtReferencePath class >> objects: aCollectionOfObjects [
	^ self items: (GtReferencePathObjectItem objects: aCollectionOfObjects)
]

{ #category : #'instance creation' }
GtReferencePath class >> simplify: aCollectionOfReferencedObjects [
	^ self
		items: (GtReferencePathSimplifiedItemsBuilder new
				referencedObjects: aCollectionOfReferencedObjects;
				build)
]

{ #category : #views }
GtReferencePath >> allReferencedObjects [
	^ Array
		new: items size
		streamContents: [ :aStream | items do: [ :each | aStream nextPutAll: each allReferencedObjects ] ]
]

{ #category : #cleaning }
GtReferencePath >> cleanOut [
	self items do: #cleanOut.
	self items: #()
]

{ #category : #printing }
GtReferencePath >> gtDisplayOn: aStream [
	items
		do: [ :o | aStream nextPutAll: o name asString ]
		separatedBy: [ aStream
				space;
				nextPut: $>;
				space ]
]

{ #category : #views }
GtReferencePath >> gtObjectsFor: aView [
	<gtView>
	items ifNil: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Objects';
		priority: 25;
		items: [ items ];
		children: [ :each | 
			| children |
			children := each allReferencedObjects
					collect: [ :object | GtReferencePathObjectItem new referencedObject: object ].
			children size = 1 ifTrue: [ #() ] ifFalse: [ children ] ];
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
					format: [ :each | each gtDisplayString ];
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

{ #category : #views }
GtReferencePath >> gtRawObjectsFor: aView [
	<gtView>
	items ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Whole path';
		items: [ self allReferencedObjects
				collect: [ :each | GtReferencePathObjectItem new referencedObject: each ] ];
		column: 'Index'
			text: [ :each :index | 
				index asRopedText
					glamorousRegularSmallSize;
					foreground: Color gray ]
			width: 40;
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
					format: [ :each | each gtDisplayString ];
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

{ #category : #accessing }
GtReferencePath >> items [
	^ items
]

{ #category : #accessing }
GtReferencePath >> items: aCollection [
	items := aCollection
]

{ #category : #updating }
GtReferencePath >> simplify [
	"Recomputes simplified path items"

	self
		items: (GtReferencePathSimplifiedItemsBuilder new
				referencedObjects: self allReferencedObjects;
				build)
]

{ #category : #accessing }
GtReferencePath >> size [ 
	^ items size
]

{ #category : #accessing }
GtReferencePath >> startObject [
	<return: #GtReferencePathItem>
	^ items first
]

{ #category : #accessing }
GtReferencePath >> targetObject [
	<return: #GtReferencePathItem>
	^ items last
]
