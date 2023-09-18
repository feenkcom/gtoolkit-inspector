Extension { #name : #GtExampleGroup }

{ #category : #'*GToolkit-Inspector' }
GtExampleGroup >> buildButtonsContainer: aButtonsContainer listWidget: anElement [
	aButtonsContainer removeChildren.
	aButtonsContainer addChild: (BrButton new 
		aptitude: BrGlamorousButtonWithLabelAptitude; beSmallSize; 
		label: self numberOfExamples asString, ' examples ';
		action: [ anElement children second items: (self examples sorted: GtMethodsSortFunction new) ]).
	aButtonsContainer addChild: (BrButton new 
		aptitude: BrGlamorousButtonWithLabelAptitude; beSmallSize; 
		label: self numberOfResults asString, ' executed ';
		action: [ anElement children second items: (self executedExamples sorted: GtMethodsSortFunction new) ]).
	aButtonsContainer addChild: (BrButton new 
		aptitude: BrGlamorousButtonWithLabelAptitude; beSmallSize; 
		label: self numberOfSuccesses asString, ' successes ';
		action: [ anElement children second items: (self successfulExamples sorted: GtMethodsSortFunction new) ]).
	aButtonsContainer addChild: (BrButton new 
		aptitude: BrGlamorousButtonWithLabelAptitude; beSmallSize; 
		label: self numberOfFailures asString, ' failures ';
		action: [ anElement children second items: (self failedExamples sorted: GtMethodsSortFunction new) ]).
	aButtonsContainer addChild: (BrButton new 
		aptitude: BrGlamorousButtonWithLabelAptitude; beSmallSize; 
		label: self numberOfErrors asString, ' errors ';
		action: [ anElement children second items: (self erroredExamples sorted: GtMethodsSortFunction new) ]).
	aButtonsContainer addChild: (BrButton new 
		aptitude: BrGlamorousButtonWithLabelAptitude; beSmallSize; 
		label: (self numberOfExamples - self numberOfResults) asString, ' skipped ';
		action: [ anElement children second items: (self skippedExamples sorted: GtMethodsSortFunction new) ]).
]

{ #category : #'*GToolkit-Inspector' }
GtExampleGroup >> gtExpandableExamplesFor: aView [
	<gtView>
	^ aView explicit
		title: 'Methods';
		priority: 1;
		stencil: [
			GtExampleGroupCoder new forItems: (self examples sorted: GtMethodsSortFunction new) ];
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
GtExampleGroup >> paintMapWith: m [
	| grouped all local |
	local := self examples select: #isMethodDefined.
	all := local 
		withDeepCollect: [ :each | each directDependencies collect: [ :dep | 
			dep example asCachedExampleWithResult ] ] 
		as: Set.
	grouped := (all asSortedCollection: [:a :b | a method name < b method name] )groupedBy: [:each | each providerClass ].
	m nodes 
		stencil: [:assoc | 
			| pane default |
			pane := BlElement new
				constraintsDo: [:c | 
					c horizontal fitContent.
					c vertical fitContent ];
				layout: BlLinearLayout vertical alignCenter;
				background: Color white;
				aptitude: BrShadowAptitude;
				margin: (BlInsets all: 10);
				padding: (BlInsets top: 0 left: 10 bottom: 10 right: 10).
			default := BlElement new
				constraintsDo: [:c | 
					c horizontal fitContent.
					c vertical fitContent ].
			default graph beChildrenContainer: #default.
			pane addChild: (BrLabel new text: assoc key name; aptitude: (BrGlamorousLabelAptitude new foreground: Color gray); margin: (BlInsets bottom: 10)).
			pane addChild: default.
			pane ];
		with: grouped associations;
		forEach: [:assoc | 
			m nodes 
				stencil: [ :anExample | | anElement aHandler |
					anElement := BlElement new.
					anElement
						geometry: BlEllipseGeometry new;
						constraintsDo: [ :c | c horizontal fitContent. c vertical fitContent];
						border: (BlBorder paint: Color black width: 2);
						background: anExample color;
						size: 20@20;
						when: BlClickEvent do: [:anEvent | anEvent target phlow spawnObject: anExample];
						aptitude: (BrGlamorousWithTooltipAptitude new 
							contentStencil: [
								| aCoderElement |
								aCoderElement := ((GtPharoMethodCoder forExample: anExample) asCoderViewModel expanded: true) 
									asExpandedOnlyElement
										vFitContentLimited;
										when: GtPhlowObjectToSpawn
											do: [:e | anElement phlow spawnTool: e tool ].
								aCoderElement properties fontSizeEm: 0.75.
								aCoderElement ];
								preferredExtent: 200@200;
								showDelay: 100 milliSeconds;
								hideDelay: 200 milliSeconds ).
					aHandler := [ :anAnnouncement | anElement enqueueTask: (BlTaskAction new action: [ anElement background: anExample color ]) ].
					anElement userData at: #exampleAnnouncementHandler_paintMapWith put: aHandler.
					anExample announcer weak when: GtExampleExecuted send: #value: to: aHandler.
					(local includes: anExample) ifFalse: [anElement border: (BlBorder paint: Color gray width: 2)].
					anElement ];
		with: assoc value. 
	m layout horizontalTree nodeDistance: 2; treesDistance: 4; levelDistance: 10.].
	m edges 
		fromNearestTightCircle;
		toNearestTightCircle;
		stencil: [ :each | 
			BlParabollaArcElement new
				curvatureFraction: 0.1;
				preventMouseEvents;
				border: (BlBorder paint: (Color gray alpha: 0.2) width: 2);
				toHead: (BlArrowheadSimpleArrow new
					border: (BlBorder builder paint: (Color gray alpha: 0.2); width: 2; build))];
		connect: all toAll: #directDependencies.
	m layout rectanglePack.
m
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
