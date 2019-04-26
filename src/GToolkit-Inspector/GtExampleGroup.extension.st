Extension { #name : #GtExampleGroup }

{ #category : #'*GToolkit-Inspector' }
GtExampleGroup >> gtExamplesFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Examples';
		priority: 11;
		actionButtonIcon: BrGlamorousIcons play 
			action: [ :aButton :aTab | 
				self runAllExamplesFrom: aButton.
				aTab viewContentElement phlow update ];
		stencil: [
	| aContainer aButtonsContainer aListView |
	aContainer := BlElement new 
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c padding: (BlInsets all: 3).
			c horizontal matchParent.
			c vertical matchParent. ].
	aButtonsContainer := BlElement new 
		layout: (BlLinearLayout horizontal cellSpacing: 3);
		constraintsDo: [ :c | 
			c padding: (BlInsets all: 3).
			c horizontal fitContent.
			c vertical fitContent.
			c linear horizontal alignCenter ].
	aContainer addChild: aButtonsContainer.

	aListView := aView columnedList
		title: 'Examples List';
		priority: 11;
		items: [ self examples ];
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
				item: [ :eachExample :anIndex |  eachExample example classLabel ];
				matchParent];
		column: 'Selector' translated do: [ :aColumn |
			aColumn 
				item: [ :eachExample :anIndex | eachExample example selector asString ];
				matchParent ];
		column: 'Result' translated do: [:aColumn |
			aColumn 
				item: [ :eachExample :anIndex | eachExample resultOrErrorName ];
				matchParent ].
	aListView asElementDo: [ :anElement | 
		aContainer addChild: anElement.
		aButtonsContainer addChild: (BrButton new 
			look: BrGlamorousButtonWithLabelLook; beSmall; 
			label: self numberOfExamples asString, ' examples ';
			action: [ anElement children second items: (self examples) ]).
		aButtonsContainer addChild: (BrButton new 
			look: BrGlamorousButtonWithLabelLook; beSmall; 
			label: self numberOfResults asString, ' executed ';
			action: [ anElement children second items: (self examples select: #hasResult) ]).
		aButtonsContainer addChild: (BrButton new 
			look: BrGlamorousButtonWithLabelLook; beSmall; 
			label: self numberOfSuccesses asString, ' sucesses ';
			action: [ anElement children second items: (self examples select: #isSuccess) ]).
		aButtonsContainer addChild: (BrButton new 
			look: BrGlamorousButtonWithLabelLook; beSmall; 
			label: self numberOfFailures asString, ' failures ';
			action: [ anElement children second items: (self examples select: #isFailure) ]).
		aButtonsContainer addChild: (BrButton new 
			look: BrGlamorousButtonWithLabelLook; beSmall; 
			label: self numberOfErrors asString, ' errors ';
			action: [ anElement children second items: (self examples select: #isError) ]).
		aButtonsContainer addChild: (BrButton new 
			look: BrGlamorousButtonWithLabelLook; beSmall; 
			label: (self numberOfExamples - self numberOfResults) asString, ' skipped ';
			action: [ anElement children second items: (self examples select: [ :e | e hasResult not ]) ]).
		 ].
	aContainer ]
]

{ #category : #'*GToolkit-Inspector' }
GtExampleGroup >> gtMapFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Map';
		priority: 90;
		painting: [ :mondrian | self paintMapWith: mondrian ]
]

{ #category : #'*GToolkit-Inspector' }
GtExampleGroup >> runAllExamplesFrom: aBrTab [
	self runAll.
	aBrTab phlow viewContent 	
		allChildrenBreadthFirstDetect: [ :aChild | 
			aChild isKindOf: BrList ] 
		ifFound: [ :aList | 
			aList children first dataSource notifyChanged ] 
		ifNone: [ 
			self error: 'I should have found a view content element, but I did not.' ]
]
