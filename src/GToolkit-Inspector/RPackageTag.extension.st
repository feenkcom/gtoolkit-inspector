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
		column: 'Name' item: [ :aRing | aRing name ];
		column: 'Category' item: [ :aRing | aRing category ]
]
