Extension { #name : #RPackage }

{ #category : #'*GToolkit-Inspector' }
RPackage >> gtDefinedClassesFor: aView [
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
RPackage >> gtDisplayOn: stream [
	stream nextPutAll: self name
]

{ #category : #'*GToolkit-Inspector' }
RPackage >> gtSpecificSizeInMemory [
	^ self sizeInMemory 
		+ classDefinedSelectors gtSpecificSizeInMemory
		+ (classDefinedSelectors sumNumbers: #gtSpecificSizeInMemory)
		+ metaclassDefinedSelectors gtSpecificSizeInMemory
		+ (metaclassDefinedSelectors sumNumbers: #gtSpecificSizeInMemory)
		+ metaclassExtensionSelectors gtSpecificSizeInMemory
		+ (metaclassExtensionSelectors sumNumbers: #gtSpecificSizeInMemory)
		+ classExtensionSelectors gtSpecificSizeInMemory
		+ (classExtensionSelectors sumNumbers: #gtSpecificSizeInMemory)
		+ classes gtSpecificSizeInMemory
		+ classTags gtSpecificSizeInMemory
		+ (classTags sumNumbers: #gtSpecificSizeInMemory)
]

{ #category : #'*GToolkit-Inspector' }
RPackage >> gtTagsFor: aView [
	<gtView>
	self tags ifEmpty: [ ^ aView empty ].
	^ aView list
		title: 'Tags';
		priority: 2;
		items: [ self tags asOrderedCollection
				sorted: [ :a :b | a name < b name ] ];
		itemText: [ :aTag | aTag name ]
]
