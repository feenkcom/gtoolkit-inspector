Extension { #name : #RPackageTag }

{ #category : #'*GToolkit-Inspector' }
RPackageTag >> gtDefinedClassesFor: aView [
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
RPackageTag >> gtExamplesFor: aView [
	<gtView>
	<gtPackageTagView>
	
	^ (GtExampleGroup withAll: self gtExamplesAllContained)
			gtExamplesFor: aView
]

{ #category : #'*GToolkit-Inspector' }
RPackageTag >> gtSpecificSizeInMemory [
	^ self sizeInMemory 
		+ classNames gtSpecificSizeInMemory
]
