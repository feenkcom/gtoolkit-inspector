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
RPackage >> gtExamplesFor: aView [
	<gtView>
	<gtPackageView>
	
	^ aView forward 
		title: 'Examples';
		priority: 11;
		object: [ GtExampleGroup withAll: (self gtExamplesAllContained collect: #asCachedExampleWithResult) ];
		view: #gtExamplesFor:
]

{ #category : #'*GToolkit-Inspector' }
RPackage >> gtSpecificSizeInMemory [
	^ self sizeInMemory 
		+ classDefinedSelectors gtSpecificSizeInMemory
		+ (classDefinedSelectors sum: #gtSpecificSizeInMemory)
		+ metaclassDefinedSelectors gtSpecificSizeInMemory
		+ (metaclassDefinedSelectors sum: #gtSpecificSizeInMemory)
		+ metaclassExtensionSelectors gtSpecificSizeInMemory
		+ (metaclassExtensionSelectors sum: #gtSpecificSizeInMemory)
		+ classExtensionSelectors gtSpecificSizeInMemory
		+ (classExtensionSelectors sum: #gtSpecificSizeInMemory)
		+ classes gtSpecificSizeInMemory
		+ classTags gtSpecificSizeInMemory
		+ (classTags sum: #gtSpecificSizeInMemory)
]

{ #category : #'*GToolkit-Inspector' }
RPackage >> gtTagsFor: aView [
	<gtView>
	self classTags ifEmpty: [ ^ aView empty ].
	^ aView list
		title: 'Tags';
		priority: 2;
		items: [ self classTags asOrderedCollection
				sorted: [ :a :b | a name < b name ] ];
		itemText: [ :aTag | aTag name ]
]
