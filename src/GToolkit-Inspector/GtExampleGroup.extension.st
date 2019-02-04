Extension { #name : #GtExampleGroup }

{ #category : #'*GToolkit-Inspector' }
GtExampleGroup >> gtExamplesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Examples';
		priority: 10;
		items: [ self examples ];
		actionStencil: [ :tab |
			BrButton new 
				look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
				icon: BrGlamorousIcons play asElement;
				action: [
					self examples 
						do: [ :each | each ignoreTest ifFalse: [ each run ] ] 
						displayingProgress: 'Running examples ...'.
					tab parentTabGroup 	
						allChildrenBreadthFirstDetect: [ :aChild | aChild phlow isViewContent ] 
						ifFound: [ :aList | aList children second children first dataSource notifyChanged ] 
						ifNone: [self error: 'I should have found a view content element, but I did not.']  ] ];
		column: 'Icon' translated do: [:aColumn |
			aColumn
				itemStencil: [ :eachExample :anIndex | 
					| anElement |
					anElement := eachExample icon asElement.
					anElement
						constraintsDo: [ :c | 
							c padding: (BlInsets top: 3 bottom: 3).
							c margin: (BlInsets top: 3 bottom: 3) ];
						when: BlClickEvent do: [ :anEvent | 
							eachExample run.
							anElement background: eachExample icon.
							anEvent consumed: true.
							anElement fireEvent: (GtPhlowObjectToSpawn new object: eachExample result returnValue; sourceElement: anElement) ] ];
				noResize];
		column: 'Class' translated do: [:aColumn | 
			aColumn 
				item: [ :eachExample :anIndex |  eachExample example methodClass name ];
				matchParent];
		column: 'Selector' translated do: [ :aColumn |
			aColumn 
				item: [ :eachExample :anIndex | eachExample example selector asString ];
				matchParent ];
		column: 'Result' translated do: [:aColumn |
			aColumn 
				item: [ :eachExample :anIndex | eachExample resultOrErrorName ];
				matchParent ]
]

{ #category : #'*GToolkit-Inspector' }
GtExampleGroup >> gtMapFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Map';
		priority: 90;
		painting: [ :mondrian | self paintMapWith: mondrian ]
]
