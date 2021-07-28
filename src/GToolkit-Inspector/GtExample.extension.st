Extension { #name : #GtExample }

{ #category : #'*GToolkit-Inspector' }
GtExample >> gtActionDebugFor: anAction [
	<gtAction>
	|  button |
	^ anAction explicit stencil: [
		button := BrButton new.
		button
			aptitude: BrGlamorousButtonWithIconAptitude;
			action:  [ [ self debug ] fork ];
			icon: BrGlamorousIcons spawn asElement;
			label: 'Debug example' translated.
	]
]

{ #category : #'*GToolkit-Inspector' }
GtExample >> gtActionSpawnReturnValueFor: anAction [
	<gtAction>
	|  button |
	^ anAction explicit stencil: [
		button := BrButton new.
		button
			aptitude: BrGlamorousButtonWithIconAptitude;
			action:  [
				button phlow spawnObject: (self runThenDo: [ :r | r returnValue ] onErrorDo: [ :r | r ]) ];
			icon: BrGlamorousVectorIcons playinspect;
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
GtExample >> gtCoderSourceFor: aView [
	<gtView>
	^ aView explicit
		title: 'Source';
		priority: 0;
		stencil: [ (GtPharoMethodCoder forExample: self) asExpandedOnlyElement ];
		actionButtonIcon: BrGlamorousVectorIcons browse 
			action: [ self method browse ]
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
		painting: [ :m | 
			m nodes 
				stencil: [ :each |
					| element |
					element := BlElement new
						geometry: BlEllipseGeometry new;
						border: (BlBorder paint: Color black width: 2);
						size: 20@20;
						aptitude: (BrWithTooltipAptitude new
							preferredExtent: 200@200;
							showDelay: 100 milliSeconds;
							hideDelay: 100 milliSeconds;
							stencil: [ 
								BlElement new aptitude: (BrTooltipAptitude new content: ((GtPharoMethodCoder forExample: each) asCoderUIModel expanded: true) asElement)]).
					each = self ifTrue: [element background: (BrGlamorousColors primaryBorderColor)].
					element ];
				with: (self withDeepCollect: #directDependencies) asSet.
			m edges 
				fromNearestTightCircle;
				toNearestTightCircle;
				stencil: [ :each | 
					BlParabollaArcElement new curvatureFraction: 0.2;
						border: (BlBorder paint: (Color gray alpha: 0.2) width: 2);
						toHead: (BlArrowheadSimpleArrow new
							border: (BlBorder builder paint: (Color gray alpha: 0.2); width: 2; build))];
				connectToAll: #directDependencies.
			m layout horizontalTree. ]
]

{ #category : #'*GToolkit-Inspector' }
GtExample >> gtProblemsFor: aView [
	<gtView>
	self hasProblems ifFalse: [ ^ aView empty ].
	^ (self problems gtItemsFor: aView)
			title: 'Problems'
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
