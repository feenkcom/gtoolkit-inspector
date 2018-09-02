Extension { #name : #GtExampleGroup }

{ #category : #'*GToolkit-Inspector' }
GtExampleGroup >> gtExamplesIn: aView [
	<gtView>
	^ aView explicit
		title: 'Examples';
		priority: 10;
		actionStencil: [ :tab |
			BrButton new 
				look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
				icon: BrGlamorousIcons play asElement;
				action: [
					self examples do: [ :each | each ignoreTest ifFalse: [ each run ] ] 
						displayingProgress: 'Running examples ...'.
					tab parentTabGroup 	
						allChildrenBreadthFirstDetect: [ :aChild | aChild phlow isViewContent ] 
						ifFound: [ :aList | aList children first dataSource notifyChanged ] 
						ifNone: [self error: 'I should have found a view content element, but I did not.']  ] ];
		stencil: [ | theExamples aList |
			theExamples := self examples.
			aList := BrColumnedList new display: theExamples.
			aList addEventHandler: (GtInspectorListToSelectHandler new transformation: [ :each | 
						(each isKindOf: GtExampleWithResult)
							ifTrue: [ each example ]
							ifFalse: [ each ] ]).
			aList column
				title: 'Icon' translated;
				stencil: [ :eachExample :anIndex | | anElement |
					anElement := eachExample icon asElement.
					anElement
						constraintsDo: [ :c | 
							c padding: (BlInsets top: 2) ];
						when: BlClickEvent do: [ :anEvent | 
							eachExample run.
							anElement background: eachExample icon.
							anEvent consumed: true.
							aList selectOne: anIndex ] ].
			aList column
				title: 'Result' translated;
				stencil: [ :eachExample :anIndex | 
					(BrListLabelStencil fitContent: eachExample resultOrErrorName) asElement
						constraintsDo: [ :c |  
							c padding: (BlInsets left: 10) ];
						when: BlClickEvent do: [ :anEvent  |
							anEvent consumed: true.
							aList selectOne: anIndex.
							eachExample hasResult ifTrue: [ 
								aList fireEvent: (GLMBlocObjectToSelect new 
									toSelect: eachExample result returnValueOrExampleException) ] ] ].
			aList column
				title: 'Selector' translated;
				stencil: [ :eachExample :anIndex | 
					(BrListLabelStencil matchParent: 
							eachExample example selector asString, ' (', 
							eachExample example methodClass name ,')' ) asElement
						constraintsDo: [ :c |  
							c padding: (BlInsets left: 10) ];
						when: BlClickEvent do: [ :anEvent  |
							anEvent consumed: true.
							aList selectOne: anIndex ] ].
			aList 
				when: BrSelectionChanged do: [ :anEvent | 
					anEvent selectedDo: [ :anInterval | 
					aList fireEvent: (GLMBlocObjectToSelect new 
						toSelect: (aList viewModel items at: (aList selection from))) ] ]
			]
]

{ #category : #'*GToolkit-Inspector' }
GtExampleGroup >> gtMapIn: aView [
	<gtView>
	^ aView mondrian
		title: 'Map';
		priority: 90;
		painting: [ :view |
			view nodes
				umlClassShapeWithName: [ :each | each key name ];
				with: (self examples groupedBy: #methodClass) associations forEach: [ :assoc | 
				view nodes
					shape: [ :each |
						BlElement new 	
							geometry: BlEllipse new;
							border: (BlBorder paint: Color black width: 2);
							size: 20@20;
							constraintsDo: [ :constraints |
								constraints padding: (BlInsets all: 10) ]";
							 addEventHandlerOn: BlMouseDownEvent do: [ :anEvent | mondrian selection: each ]"	];
					with: assoc value.
				view layout tree levelDistance: 100 ].
			view edges 
				fromCenterBottom;
				toCenterTop;
				shape: [ :each | 
					BlLineElement new
						border: (BlBorder paint: (Color gray alpha: 0.2) width: 1) ];
				connect: self examples 
					from: #yourself 
					toAll: [:each | 
						self select: [:exampleWithResult | 
							each directDependencies anySatisfy: [ :dependency | exampleWithResult example = dependency ]]].
			view layout custom: GtGraphGridLayout new ]
]
