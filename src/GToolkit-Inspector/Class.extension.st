Extension { #name : 'Class' }

{ #category : '*GToolkit-Inspector' }
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

{ #category : '*GToolkit-Inspector' }
Class >> gtDefinitionFor: aView [
	<gtView>
	^ aView textEditor  
		title: 'Definition';
		priority: 1; 
		styler: (BrRBTextStyler new 
				isForWorkspace: true;
				yourself);
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ self definition asRopedText ].
]

{ #category : '*GToolkit-Inspector' }
Class >> gtExamplesFor: aView [
	<gtView>
	self gtExamplesAll isEmpty ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'Examples';
		priority: 20;
		object: [ GtExampleGroup withAll: self gtExamplesAll ];
		view: #gtExamplesFor:
]

{ #category : '*GToolkit-Inspector' }
Class >> gtInstanceVariablesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'InstVars';
		priority: 5;
		items: [ self class allInstVarNames sorted
				collect: [ :each | each -> (self instVarNamed: each) ] ];
		column: 'Variable' item: #key;
		column: 'Value' item: #value;
		send: #value
]

{ #category : '*GToolkit-Inspector' }
Class >> gtMethodsFor: aView [
	<gtView>
	^ aView explicit
		title: 'Methods' translated;
		priority: 2;
		stencil: [ (GtClassMethodsCoder forClass: self) asElement ]
]

{ #category : '*GToolkit-Inspector' }
Class >> itOrItsSuperclassesDefineGTViews [
	"Says whether this class or its superclasses define a dedicated gtView.
	ProtoObject and Object are excluded because they are too generic"
	^ self withAllSuperclasses \ { ProtoObject . Object } anySatisfy: [ :c | 
		(Pragma allNamed: #gtView in: c) notEmpty ]
]
