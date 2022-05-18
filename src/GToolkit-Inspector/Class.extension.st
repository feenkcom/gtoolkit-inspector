Extension { #name : #Class }

{ #category : #'*GToolkit-Inspector' }
Class >> gtAllReferencesOutsideFor: aView [
	<gtView>
	^ aView explicit
		title: 'All Ref Outside';
		priority: 41;
		stencil: [ | list |
			list := BrColumnedList new
				items: [ ((SystemNavigation default allReferencesTo: self binding)
						reject: [ :method | method package name == self package name ])
						sorted: [ :x :y | x name < y name ] ].
			list column
				title: 'Method';
				stencil: [ :each | BrColumnCellLabelStencil matchParent: each name ].
			list column
				title: 'Package';
				stencil: [ :each | BrColumnCellLabelStencil matchParent: each package name ].
			list ]
]

{ #category : #'*GToolkit-Inspector' }
Class >> gtClassSlotsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Class Slots';
		priority: 6;
		items: [ self classVarNames sorted
				collect: [ :each | each -> (self classVarNamed: each) ] ];
		column: 'Variable' text: #key;
		column: 'Value' text: #value;
		send: #value
]

{ #category : #'*GToolkit-Inspector' }
Class >> gtDefinitionFor: aView [

	<gtView>
	^ aView textEditor
		  title: 'Definition';
		  priority: 1;
		  styler: (BrRBTextStyler new
				   isForWorkspace: true;
				   yourself);
		  aptitude: BrGlamorousCodeEditorAptitude;
		  text: [ self definitionString asRopedText ]
]

{ #category : #'*GToolkit-Inspector' }
Class >> gtExamplesFor: aView [

	<gtView>
	<gtClassView>
	self gtExamplesAll isEmpty ifTrue: [ ^ aView empty ].
	^ aView explicit
		  title: 'Examples';
		  priority: 20;
		  stencil: [ 
			  | aGroup aGroupView anElement |
			  aGroup := GtExampleGroup withAll: self gtExamplesAll.
			  aGroupView := GtPhlowView empty
				                on: aGroup
				                perform: #gtExamplesFor:.
			  anElement := aGroupView asElement.
			  anElement userData at: #gtExamplesFor: put: aGroup.
			  anElement ];
		  actionButtonIcon: BrGlamorousVectorIcons play
		  tooltip: 'Run all examples'
		  action: [ :aButton :aTab | 
			  aTab viewContentElement withAllChildrenBreadthFirstDo: [ 
					  :anElement | 
					  anElement userData
						  at: #gtExamplesFor:
						  ifPresent: [ :aGroup | 
							  aGroup runAll. ]
						  ifAbsent: [ "ignore" ] ] ];
		  actionUpdateButtonTooltip: 'Update example list'
]

{ #category : #'*GToolkit-Inspector' }
Class >> gtInstanceSlotsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Instance Slots';
		priority: 5;
		items: [ self class allInstVarNames sorted
				collect: [ :each | each -> (self instVarNamed: each) ] ];
		column: 'Variable' text: #key;
		column: 'Value' text: #value;
		send: #value
]

{ #category : #'*GToolkit-Inspector' }
Class >> gtMethodsFor: aView [
	<gtView>
	^ aView explicit
		title: 'Methods' translated;
		priority: 2;
		stencil: [ (GtClassMethodsCoder forClass: self) asElement ]
]

{ #category : #'*GToolkit-Inspector' }
Class >> gtSpecificSizeInMemory [
	^ super gtSpecificSizeInMemory 
		+ ((subclasses ifNil: [ 0 ] ifNotNil: [ subclasses sizeInMemory ]))
		+ ((classPool ifNil: [ 0 ] ifNotNil: [ classPool gtSpecificSizeInMemory ]))
		+ ((sharedPools ifNil: [ 0 ] ifNotNil: [ sharedPools gtSpecificSizeInMemory ]))
]

{ #category : #'*GToolkit-Inspector' }
Class >> itOrItsSuperclassesDefineGTViews [
	"Says whether this class or its superclasses define a dedicated gtView.
	ProtoObject and Object are excluded because they are too generic"
	^ self withAllSuperclasses \ { ProtoObject . Object } anySatisfy: [ :c | 
		(Pragma allNamed: #gtView in: c) notEmpty ]
]
