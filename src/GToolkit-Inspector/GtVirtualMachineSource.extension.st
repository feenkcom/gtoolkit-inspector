Extension { #name : #GtVirtualMachineSource }

{ #category : #'*GToolkit-Inspector' }
GtVirtualMachineSource >> gtOverviewConnect: aFromThing with: aToThing in: aContainerElement [
	(aContainerElement graph findAllNodeChildren: aFromThing) ifNotEmpty: [ :allFromElements |
		(aContainerElement graph findAllNodeChildren: aToThing) ifNotEmpty: [ :allToElements |
			allFromElements do: [ :aFromElement |
				allToElements do: [ :aToElement |
					| anEdge |
					anEdge := BlParabollaArcElement new
						border: (BlBorder paint: (Color gray alpha: 0.2) width: 5);
						fromAnchor: (BlElementCenterAnchor element: aFromElement);
						toAnchor: (BlElementCenterAnchor element: aToElement);
						toHead: (BlArrowheadSimpleArrow new background: (Color gray alpha: 0.2)).
						
						aContainerElement addChild: anEdge ] ] ] ]
]

{ #category : #'*GToolkit-Inspector' }
GtVirtualMachineSource >> gtOverviewConnectAll: aCollectionOfThings in: aContainerElement [
	aCollectionOfThings do: [ :eachThing |
		eachThing dependencies do: [ :eachDependency |
			self gtOverviewConnect: eachThing with: eachDependency in: aContainerElement ] ]
]

{ #category : #'*GToolkit-Inspector' }
GtVirtualMachineSource >> gtOverviewFlowElementFor: aCollectionOfThings [
	^ BrHorizontalFlow new
		hMatchParent;
		vFitContent;
		addChildren: (aCollectionOfThings collect: [ :eachThing |
			BrButton new
				fitContent;
				aptitude: BrGlamorousLabelAptitude + BrShadowAptitude + (BrStyleCommonAptitude new
					default: [ :aStyle | aStyle background: Color white ];
					hovered: [ :aStyle | aStyle background: Color veryVeryLightGray muchLighter ];
					pressed: [ :aStyle | aStyle background: Color veryVeryLightGray lighter ]);
				label: eachThing name;
				padding: (BlInsets top: 10 right: 20 bottom: 10 left: 20);
				margin: (BlInsets all: 10);
				action: [ :aButton | aButton phlow spawnObject: eachThing ];
				in: [ :aButton | aButton graph beNode: eachThing ];
				yourself ])
]

{ #category : #'*GToolkit-Inspector' }
GtVirtualMachineSource >> gtOverviewFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Overview';
		priority: 1;
		stencil: [
			(BrVerticalPane new
				hMatchParent;
				vFitContent;
				cellSpacing: 20;
				padding: (BlInsets left: 20 right: 20);
				addChild: (BrLabel new
						alignCenter;
						hMatchParent;
						aptitude: (BrGlamorousLabelAptitude new fontSize: 20; foreground: Color gray);
						text: 'Virtual Machine');
				addChild: (BrVerticalPane new
					hMatchParent;
					vFitContent;
					addAptitude: BrShadowAptitude;
					background: Color white;
					padding: (BlInsets all: 10);
					addChild: (BrLabel new
						alignCenter;
						hMatchParent;
						aptitude: (BrGlamorousLabelAptitude new fontSize: 20);
						text: 'Core');
					addChild: (BrLabel new
						alignCenter;
						aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
						text: 'Features';
						margin: (BlInsets left: 10));
					addChild: (self gtOverviewFlowElementFor: core features);
					addChild: (BrLabel new
						alignCenter;
						aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
						text: 'Libraries';
						margin: (BlInsets left: 10));
					addChild: (self gtOverviewFlowElementFor: libraries);
					addChild: (BrLabel new
						alignCenter;
						aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
						text: 'System Libraries';
						margin: (BlInsets left: 10));
					addChild: (self gtOverviewFlowElementFor: systemLibraries));
				addChild: (BrVerticalPane new
					hMatchParent;
					vFitContent;
					addAptitude: BrShadowAptitude;
					background: Color white;
					margin: (BlInsets top: 10);
					padding: (BlInsets all: 10);
					addChild: (BrLabel new
						alignCenter;
						hMatchParent;
						aptitude: (BrGlamorousLabelAptitude new fontSize: 20);
						text: 'Plugins');
					addChild: (self gtOverviewFlowElementFor: plugins));
				in: [ :aContainerElement |
					self gtOverviewConnectAll: core features in: aContainerElement.
					self gtOverviewConnectAll: plugins in: aContainerElement.
				];
			yourself) asScrollableElement
		]
]

{ #category : #'*GToolkit-Inspector' }
GtVirtualMachineSource >> gtPluginsFor: aView [
	<gtView>
	
	^ aView list
		title: 'Plugins';
		priority: 2;
		items: [ plugins ];
		itemText: [ :each | each name ]
]
