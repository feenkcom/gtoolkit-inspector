Extension { #name : #GtExample }

{ #category : #'*GToolkit-Inspector' }
GtExample >> gtActionSpawnReturnValueFor: anAction [
	<gtAction>
	|  button |
	^ anAction explicit stencil: [
		button := BrButton new.
		button
			look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
			action:  [
				button fireEvent: (GtPhlowObjectToSpawn new
					object: (self runThenDo: [ :r | r returnValue ] onErrorDo: [ :r | r ]);
					sourceElement: button) ];
			icon: BrGlamorousIcons play asElement;
			label: 'Evaluate and inspect return-value' translated.
	]
]

{ #category : #'*GToolkit-Inspector' }
GtExample >> gtAfterFor: aView [
	<gtView>
	self hasAfter ifFalse: [ ^ aView empty ].
	^ ({ self after } gtItemsFor: aView)
			title: 'After'
]

{ #category : #'*GToolkit-Inspector' }
GtExample >> gtCodeGraphFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Code Graph';
		painting: [ :view |
			view nodes 
				shape: [ :each | 
					| text styler editor editorElement |
					text := each method sourceCode asRopedText.
					styler := GtExamplesStyler new classOrMetaClass: each methodClass.
					editor := BrTextEditor new.
					editor styler: styler.
					editor text: text.
					editorElement := BrEditorElement new.
					editorElement
						zIndex: 10;
						background: Color white;
						effect: (BlDropShadowEffect color: (Color gray alpha: 0.5) width: 10 offset: 5@5).
					editorElement constraintsDo: [ :c |
					    c horizontal exact: 300.
					    c vertical exact: 200 ].
					editorElement editor: editor.
					editorElement ];
				with: (self withDeepCollect: #directDependencies) asSet.
			view edges 
				fromNearestCircle;
				toNearestCircle;
				shape: [ :each | 
					BlLineElement new
						border: (BlBorder paint: (Color gray alpha: 0.4) width: 3);
						toHead: (BlArrowheadSimpleArrow new
							border: (BlBorder builder paint: (Color gray alpha: 0.4); width: 3; build))
					"BlParabollaArcElement new 
						border: (BlBorder paint: (Color gray alpha: 0.4) width: 10);
						curvatureFraction: 0.9;
						toHead: (BlArrowheadSimpleArrow new
							border: (BlBorder builder paint: (Color gray alpha: 0.4); width: 10; build))" ];
				connectToAll: #directDependencies.
			view layout horizontalDominanceTree levelDistance: 200; nodeDistance: 40 ]
]

{ #category : #'*GToolkit-Inspector' }
GtExample >> gtCoderSourceFor: aView [
	<gtView>
	^ aView explicit
		title: 'Source';
		priority: 0;
		stencil: [ (GtMethodCoder forExample: self) expanded: true ]
]

{ #category : #'*GToolkit-Inspector' }
GtExample >> gtDependenciesFor: aView [
	<gtView>
	^ self directDependencies 
		ifEmpty: [ aView empty ] 
		ifNotEmpty: [ :aCollection | 
			(aCollection asOrderedCollection gtItemsFor: aView)
				title: 'Dependencies' ]
	
	
]

{ #category : #'*GToolkit-Inspector' }
GtExample >> gtDependenciesGraphFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Graph';
		priority: 50;
		painting: [ :view | 
			view nodes 
				stencil: [ :each |
					| element |
					element := BlElement new.
					element 	
						geometry: BlEllipse new;
						border: (BlBorder paint: Color black width: 2);
						size: 20@20;
						constraintsDo: [ :constraints | constraints padding: (BlInsets all: 10).
					each = self ifTrue: [element background: Color gray] ifFalse: [element background:  Color white]  ].
					element ];
				with: (self withDeepCollect: #directDependencies) asSet.
			view edges connectToAll: #directDependencies.
			view layout tree ]
]

{ #category : #'*GToolkit-Inspector' }
GtExample >> gtProblemsFor: aView [
	<gtView>
	self hasProblems ifFalse: [ ^ aView empty ].
	^ (self problems gtItemsFor: aView)
			title: 'Problems'
]

{ #category : #'*GToolkit-Inspector' }
GtExample >> gtSourceFor: aView [
	<gtView>
	^ aView explicit
		title: 'Source';
		priority: 10;
		stencil: [ 
			| text styler editor editorElement |
			text := self method sourceCode asRopedText.
			text attributes: { BlFontGenericFamilyAttribute monospace beNotOverwritableByStyler . (BlFontSizeAttribute new size: 14) beNotOverwritableByStyler}.
			styler := GtExamplesStyler new classOrMetaClass: self methodClass.
			editor := BrTextEditor new.
			editor styler: styler.
			editor text: text.
			editorElement := BrEditorElement new.
			editorElement constraintsDo: [ :c |
			    c horizontal matchParent.
			    c vertical matchParent ].
			editorElement editor: editor ];
		actionStencil: [ BrButton new 
			look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
			icon: BrGlamorousIcons browse asElement ;
			action: [ self method browse ] 
		]
]

{ #category : #'*GToolkit-Inspector' }
GtExample >> gtSubjectsFor: aView [
	<gtView>
	self hasSubjects ifFalse: [ ^ aView empty ].
	"^ ((self subjects gtItemsFor: aView)
		actionStencil: [ BrButton new 
			look: BrMaterialToggleLabelledLook;
			icon: (Smalltalk ui icons iconNamed: #glamorousBookmark);
			action: [ GtExampleNavigation browseAllExampleSubjects: { self } ] 
		])
		title: 'Subjects'"
	^ (self subjects gtItemsFor: aView)
		title: 'Subjects'
		
]
