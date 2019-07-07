Extension { #name : #RPackage }

{ #category : #'*GToolkit-Inspector' }
RPackage >> gtDefinedClassesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Classes';
		priority: 1;
		items: [ self classes collect: #asRingDefinition as: OrderedCollection ];
		column: 'Name' do: [ :aColumn |  aColumn
			item: [ :aRing | aRing name ];
			matchParent ];
		column: 'Category' do: [ :aColumn |  aColumn
			item: [ :aRing | aRing category ];
			matchParent ]
]

{ #category : #'*GToolkit-Inspector' }
RPackage >> gtDisplayOn: stream [
	stream nextPutAll: self name
]

{ #category : #'*GToolkit-Inspector' }
RPackage >> gtTagsFor: aView [
	<gtView>
	self classTags ifEmpty: [ ^ aView empty ].
	^ aView list
		title: 'Tags';
		priority: 2;
		items: [ self classTags asOrderedCollection ];
		itemFormat: [ :aTag | aTag name ]
]
