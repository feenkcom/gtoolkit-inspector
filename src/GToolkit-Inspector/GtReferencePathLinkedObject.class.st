Class {
	#name : #GtReferencePathLinkedObject,
	#superclass : #Object,
	#instVars : [
		'predecessor',
		'successor'
	],
	#category : #'GToolkit-Inspector-Reference Path'
}

{ #category : #factory }
GtReferencePathLinkedObject class >> linkPath: aPath [
	"aPath parameter is a list of GtReferencedObject instances"

	<return: #Collection of: #GtReferencedObject>
	aPath ifEmpty: [ ^ #() ].
	aPath size = 1 ifTrue: [ ^ aPath ].

	^ Array
		new: aPath size
		streamContents: [ :aStream | 
			aStream nextPut: aPath first.
			aStream
				nextPutAll: (aPath
						overlappingPairsCollect: [ :a :b | 
							GtReferencePathLinkedObject new
								predecessor: a;
								successor: b ]) ]
]

{ #category : #factory }
GtReferencePathLinkedObject class >> linkPaths: aCollectionOfPaths [
	^ aCollectionOfPaths collect: [ :eachPath | self linkPath: eachPath ]
]

{ #category : #printing }
GtReferencePathLinkedObject >> gtDisplayOn: stream [
	self object gtDisplayOn: stream
]

{ #category : #views }
GtReferencePathLinkedObject >> gtRawObjectsFor: aView [
	<gtView>
	predecessor ifNil: [ ^ aView empty ].
	successor ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Objects';
		items: [ {self predecessor.
				self successor}
				collect: [ :each | GtReferencePathObjectItem new referencedObject: each ] ];
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
					format: [ :each | each gtDisplayString ] ];
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
GtReferencePathLinkedObject >> object [
	^ self referencedObject object
]

{ #category : #accessing }
GtReferencePathLinkedObject >> predecessor [
	^ predecessor
]

{ #category : #accessing }
GtReferencePathLinkedObject >> predecessor: anObject [
	predecessor := anObject
]

{ #category : #accessing }
GtReferencePathLinkedObject >> referenceTypeName [
	(self successor isKindOf: GtReferencedInstanceVariable)
		ifTrue: [ self predecessor object class allSlots
				detect: [ :eachSlot | eachSlot isVirtual not and: [ eachSlot index = (self successor instVarIndex + 1) ] ]
				ifFound: [ :aSlot | ^ aSlot name ]
				ifNone: [  ] ].

	^ self referencedObject referenceTypeName
]

{ #category : #printing }
GtReferencePathLinkedObject >> referencedObject [
	^ self successor
]

{ #category : #accessing }
GtReferencePathLinkedObject >> successor [
	^ successor
]

{ #category : #accessing }
GtReferencePathLinkedObject >> successor: anObject [
	successor := anObject
]
