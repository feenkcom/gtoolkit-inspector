Extension { #name : #PackageTag }

{ #category : #'*GToolkit-Inspector' }
PackageTag >> gtDefinedClassesFor: aView [
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
PackageTag >> gtExamplesFor: aView [
	<gtView>
	<gtPackageTagView>
	
	^ (GtExampleGroup withAll: self gtExamplesAllContained)
			gtExamplesFor: aView
]

{ #category : #'*GToolkit-Inspector' }
PackageTag >> gtSpecificSizeInMemory [
	^ self sizeInMemory 
		+ classes gtSpecificSizeInMemory
]
