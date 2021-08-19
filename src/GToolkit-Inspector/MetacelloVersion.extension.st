Extension { #name : 'MetacelloVersion' }

{ #category : '*GToolkit-Inspector' }
MetacelloVersion >> gtPackagesFor: aView [
	<gtView>
	^ aView list
		title: 'Packages';
		priority: 50;
		items: [ self packages ];
		itemText: [ :aNode | 
			[ aNode gtDisplayString asRopedText ]
				on: Error
				do: [ aNode errorMessage asRopedText foreground: Color red ] ]
]

{ #category : '*GToolkit-Inspector' }
MetacelloVersion >> gtProjectMapFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Project map';
		priority: 70;
		painting: [ :mondrian |
			mondrian nodes 
				shape: [:each | 
					| text |
					text := [
						((each asString 
							copyReplaceAll: 'baseline [BaselineOf' with: '') 
							copyReplaceAll: 'ConfigurationOf' with: '') asRopedText glamorousRegularFont
						foreground: Color black ]
						on: Error do: [:e | e asString asRopedText glamorousRegularFont foreground: Color red ].
					BlTextElement new text: text ];
				with: ((self 
					withDeepCollect: [ :each | each projects collect: #version ] 
					as: Set) 	reject: #isNil).
			mondrian edges
				shape: [ :each |
					BlLineElement new 
						zIndex: -1;
						border: (BlBorder paint: (Color gray alpha: 0.5) width: 2);
"						curvatureFraction: 0.1;"
						toHead: (BlArrowheadSimpleArrow new
							border: (BlBorder builder paint: (Color gray alpha: 0.5); width: 2; build))  ];
				fromRightCenter;
				toLeftCenter;
				connectFrom: #yourself 
				toAll: [:each | each projects collect: #version].
			mondrian layout horizontalDominanceTree nodeDistance: 10; levelDistance: 10 ]
]

{ #category : '*GToolkit-Inspector' }
MetacelloVersion >> gtProjectsFor: aView [
	<gtView>
	^ aView list
		title: 'Projects';
		priority: 60;
		items: [ self projects ];
		itemText: [ :aNode | 
			[ aNode gtDisplayString asRopedText ]
				on: Error
				do: [ aNode errorMessage asRopedText foreground: Color red ] ];
		send: #version
]
