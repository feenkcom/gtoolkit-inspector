Class {
	#name : #GtReferencePath,
	#superclass : #Object,
	#instVars : [
		'objects'
	],
	#category : #'GToolkit-Inspector'
}

{ #category : #'as yet unclassified' }
GtReferencePath >> gtDisplayOn: aStream [
	objects
		do: [ :o | aStream print: o class ]
		separatedBy: [ aStream
				space;
				nextPut: $>;
				space ]
]

{ #category : #views }
GtReferencePath >> gtObjectsFor: aView [
	<gtView>
	objects ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Objects';
		items: [ objects ];
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
				each class name asRopedText
					glamorousRegularSmallSize;
					foreground: Color gray ]
			width: 100;
		column: 'Package'
			text: [ :each | 
				each class package name asRopedText
					glamorousRegularSmallSize;
					foreground: Color gray ]
			width: 100
]

{ #category : #accessing }
GtReferencePath >> objects: aCollection [
	objects := aCollection
]

{ #category : #'as yet unclassified' }
GtReferencePath >> size [ 
	^ objects size
]

{ #category : #'as yet unclassified' }
GtReferencePath >> startObject [
	^ objects first
]

{ #category : #'as yet unclassified' }
GtReferencePath >> targetObject [
	^ objects last
]
