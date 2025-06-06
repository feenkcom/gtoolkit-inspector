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
GtReferencePath class >> simplify: aCollectionOfObjects [
	^ self items: (GtReferencePathSimplifiedItemsBuilder new objects: aCollectionOfObjects; build)
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
	^ aView columnedList
		title: 'Objects';
		items: [ items ];
		column: 'Value'
			textDo: [ :aColumn | 
				aColumn
					item: [ :each | each ];
					format: [ :each | each gtDisplayString ];
					background: [ :each | 
						each = self targetObject
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
			action: [ :element :item | element phlow spawnObject: item object ];
		contextItemLabel: 'Spawn reference path item'
			action: [ :element :item | element phlow spawnObject: item ]
]

{ #category : #accessing }
GtReferencePath >> items [
	^ items
]

{ #category : #accessing }
GtReferencePath >> items: aCollection [
	items := aCollection
]

{ #category : #'as yet unclassified' }
GtReferencePath >> size [ 
	^ items size
]

{ #category : #'as yet unclassified' }
GtReferencePath >> startObject [
	^ items first
]

{ #category : #'as yet unclassified' }
GtReferencePath >> targetObject [
	^ items last
]
