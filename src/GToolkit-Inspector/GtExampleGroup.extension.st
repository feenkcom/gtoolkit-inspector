Extension { #name : #GtExampleGroup }

{ #category : #'*GToolkit-Inspector' }
GtExampleGroup >> buildButtonsContainer: aButtonsContainer listWidget: anElement [
	aButtonsContainer removeChildren.
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
		label: self numberOfSuccesses asString, ' successes ';
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
		action: [ anElement children second items: (self examples reject: [ :e | e hasResult ]) ]).
]

{ #category : #'*GToolkit-Inspector' }
GtExampleGroup >> buildListViewFor: aView [
	| aListView |
	aListView := aView columnedList
		title: 'Examples List';
		priority: 11;
		items: [ self examples ];
		column: 'Status' translated do: [ :aColumn | 
			aColumn
				width: 26;
				cellStencil: [ 
					BlElement new
						size: 16@16;
						padding: (BlInsets top: 3 bottom: 3);
						margin: (BlInsets top: 3 bottom: 3);
						addLook: (GtPhlowLabelTooltipLook new 
							text: 'Click to run example');
						when: BlClickEvent
							do: [ :anEvent |
								anEvent currentTarget userData
									at: #example
									ifPresent: [ :anExample |
										anEvent consumed: true.
										anExample run.
										anEvent currentTarget background: anExample icon.
										anEvent currentTarget phlow 
											selectObject: anExample result 
												returnValueOrExampleException ]
									ifAbsent: [ "do nothing" ] ] ];
			dataBinder: [ :aLabel :anExample :aRowIndex :aRowHolder :aCellIndex |
					aLabel userData
						at: #example
						ifPresent: [ :theExample | theExample announcer unsubscribe: self ]
						ifAbsent: [ "do nothing" ].
					(anExample announcer
						when: GtExampleExecuted
						do: [ :anAnnouncement | aLabel background: anAnnouncement result icon ])
							subscriber: self.
					aLabel background: anExample icon.
					aLabel userData at: #example put: anExample ] ];
		column: 'Class' translated 
			item: [ :eachExample :anIndex | 
				eachExample example classLabel ];
		column: 'Selector' translated 
			item: [ :eachExample :anIndex | 
				eachExample example selector asString ];
		column: 'Result' translated do: [ :aColumn | 
			aColumn
				cellStencil: [
					BrLabel new
						look: BrGlamorousListLabelLook;
						addLook: (GtPhlowLabelTooltipLook new 
							text: 'Click to display result details');
						fitContent;
						when: BlClickEvent
						do: [ :anEvent |
							anEvent currentTarget userData
								at: #example
								ifPresent: [ :anExample |
									anExample hasResult ifTrue: [ | aResult |
										aResult := anExample result returnValueOrExampleException.
										(aResult isKindOf: BlElement) ifTrue: [ 
											aResult removeFromParent ].
										anEvent currentTarget phlow spawnObject: aResult.
										anEvent consumed: true ] ]
								ifAbsent: [ "do nothing" ] ] ];
				dataBinder: [ :aLabel :anExample :aRowIndex :aRowHolder :aCellIndex |
					aLabel userData
						at: #example
						ifPresent: [ :theExample | theExample announcer unsubscribe: self ]
						ifAbsent: [ "do nothing" ].
					(anExample announcer
						when: GtExampleExecuted
						do: [ :anAnnouncement | aLabel text: anExample resultOrErrorName asRopedText ])
							subscriber: self.
					aLabel text: anExample resultOrErrorName asRopedText.
					aLabel userData at: #example put: anExample ] ].
	^ aListView
]

{ #category : #'*GToolkit-Inspector' }
GtExampleGroup >> gtExamplesFor: aView [
	<gtView>
	^ aView explicit
		title: 'Examples';
		priority: 11;
		actionButtonIcon: BrGlamorousVectorIcons play
			tooltip: 'Run all examples'
			action: [ :aButton :aTab | 
				self runAllExamplesFrom: aButton.
				aTab viewContentElement phlow update ];
		actionUpdateButtonTooltip: 'Update example list';
		stencil: [ | aContainer aButtonsContainer aListView |
			aContainer := BlElement new
				layout: BlLinearLayout vertical;
				constraintsDo: [ :c | 
					c padding: (BlInsets all: 3).
					c horizontal matchParent.
					c vertical matchParent ].
			aButtonsContainer := BlElement new
				layout: (BlLinearLayout horizontal cellSpacing: 3);
				constraintsDo: [ :c | 
					c padding: (BlInsets all: 3).
					c horizontal fitContent.
					c vertical fitContent.
					c linear horizontal alignCenter ].
			aContainer addChild: aButtonsContainer.
			aListView := self buildListViewFor: aView.
			aListView
				asElementDo: [ :anElement | 
					self announcer
						when: GtExamplesExecuted , GtExampleExecuted
						do:
							[ :anAnnouncement | self buildButtonsContainer: aButtonsContainer listWidget: anElement ].
					aContainer addChild: anElement.
					self
						buildButtonsContainer: aButtonsContainer
						listWidget: anElement ].
			aContainer ]
]

{ #category : #'*GToolkit-Inspector' }
GtExampleGroup >> gtExpandableExamplesFor: aView [
	<gtView>
	^ aView explicit
		title: 'Examples';
		priority: 1;
		stencil: [
			GtExampleGroupCoder new forItems: self examples ];
		actionButtonIcon: BrGlamorousVectorIcons play 
			tooltip: 'Run all examples'
			action: [ :aButton | self runAll ]
]

{ #category : #'*GToolkit-Inspector' }
GtExampleGroup >> gtMapFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Map';
		priority: 90;
		painting: [ :mondrian | self paintMapWith: mondrian ];
		actionUpdateButtonTooltip: 'Update examples map'
]

{ #category : #'*GToolkit-Inspector' }
GtExampleGroup >> runAllExamplesFrom: aBrTab [
	self runAll.
	"aBrTab phlow viewContent 	
		allChildrenBreadthFirstDetect: [ :aChild | 
			aChild isKindOf: BrList ] 
		ifFound: [ :aList | 
			aList children first dataSource notifyChanged ] 
		ifNone: [ 
			self error: 'I should have found a view content element, but I did not.' ]"
]
