Extension { #name : #Package }

{ #category : #'*GToolkit-Inspector' }
Package >> gtDefinedClassesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Classes';
		priority: 1;
		items: [ (self classes sorted: [ :a :b | a name < b name ])
				collect: #asRingDefinition
				as: OrderedCollection ];
		column: 'Name' text: [ :aRing | aRing name ];
		column: 'Category' text: [ :aRing | aRing category ]
]

{ #category : #'*GToolkit-Inspector' }
Package >> gtDisplayOn: stream [
	stream nextPutAll: self name
]

{ #category : #'*GToolkit-Inspector' }
Package >> gtSpecificSizeInMemory [
	^ self shouldBeImplemented
]

{ #category : #'*GToolkit-Inspector' }
Package >> gtTagsFor: aView [
	<gtView>
	self tags ifEmpty: [ ^ aView empty ].
	^ aView list
		title: 'Tags';
		priority: 2;
		items: [ self tags asOrderedCollection
				sorted: [ :a :b | a name < b name ] ];
		itemText: [ :aTag | aTag name ]
]
