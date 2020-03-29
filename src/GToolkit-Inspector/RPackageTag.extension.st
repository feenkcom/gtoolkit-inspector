Extension { #name : #RPackageTag }

{ #category : #'*GToolkit-Inspector' }
RPackageTag >> gtDefinedClassesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Classes';
		priority: 1;
		items: [ (self classes sorted: [ :a :b | a name < b name ])collect: #asRingDefinition as: OrderedCollection ];
		column: 'Name' do: [ :aColumn |  aColumn
			item: [ :aRing | aRing name ];
			matchParent ];
		column: 'Category' do: [ :aColumn |  aColumn
			item: [ :aRing | aRing category ];
			matchParent ]
]
