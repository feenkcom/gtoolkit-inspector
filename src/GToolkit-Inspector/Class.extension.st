Extension { #name : #Class }

{ #category : #'*GToolkit-Inspector' }
Class >> gtAllReferencesOutsideFor: aView [
	<gtView>
	^ aView explicit
		title: 'All ref outside';
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
		title: 'Class slots';
		priority: 7;
		items: [ self class class allInstVarNames sorted
				collect: [ :each | each -> (self class instVarNamed: each) ] ];
		column: 'Variable' text: #key;
		column: 'Value' text: #value;
		send: #value
]

{ #category : #'*GToolkit-Inspector' }
Class >> gtClassVariablesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Class variables';
		priority: 6;
		items: [ self allClassVarNames sorted
				collect: [ :each | each -> (self bindingOf: each) ] ];
		column: 'Variable' text: #key;
		column: 'Value' text: #value;
		send: #value
]

{ #category : #'*GToolkit-Inspector' }
Class >> gtDefinitionFor: aView [

	<gtView>
	<gtClassView>
	^ aView explicit 
		title: 'Definition';
		priority: 20;
		stencil: [ (GtPharoSnippetCoder forSource: self definitionString) asExpandedOnlyElement vFitContentLimited ]
]

{ #category : #'*GToolkit-Inspector' }
Class >> gtInstanceSlotsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Instance slots';
		priority: 5;
		items: [ self instanceSide allSlots sorted: [:a :b | a name < b name ] ];
		column: 'Slot' text: #name;
		column: 'Type' text: [:each | each class name ];
		column: 'Defining class' text: [:each | each definingClass name ]
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
