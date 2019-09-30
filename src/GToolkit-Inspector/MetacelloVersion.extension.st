Extension { #name : #MetacelloVersion }

{ #category : #'*GToolkit-Inspector' }
MetacelloVersion >> gtPackagesFor: aView [
	<gtView>
	^ aView explicit
		title: 'Packages';
		priority: 50;
		stencil: [ 
			| list |
			list := BrColumnedList new display: [ self packages ].
			list addEventHandler: GtInspectorListToSelectHandler new.
			list column
				title: 'Packages';
				stencil: [ :aNode :index |
					| text textElement |
					text := [ aNode gtDisplayString asRopedText ] 
						on: Error 
						do: [ aNode errorMessage asRopedText foreground: Color red ].
					textElement := (BrColumnCellLabelStencil matchParent: text) asElement.
					textElement constraintsDo: [ :c | c horizontal matchParent. c padding: (BlInsets left: 10) ] ].
			list ]
]

{ #category : #'*GToolkit-Inspector' }
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
							copyReplaceAll: 'ConfigurationOf' with: '') asRopedText
						foreground: Color black ]
						on: Error do: [:e | e asString asRopedText foreground: Color red ].
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

{ #category : #'*GToolkit-Inspector' }
MetacelloVersion >> gtProjectsFor: aView [
	<gtView>
	^ aView explicit
		title: 'Projects';
		priority: 60;
		stencil: [ 
			| list |
			list := BrColumnedList new display: [ self projects ].
			list addEventHandler: GtInspectorListToSelectHandler new.
			list column
				title: 'Project';
				stencil: [ :aNode :index |
					| text textElement |
					text := [ aNode gtDisplayString asRopedText ] 
						on: Error 
						do: [ aNode errorMessage asRopedText foreground: Color red ].
					textElement := (BrColumnCellLabelStencil matchParent: text) asElement.
					textElement constraintsDo: [ :c | c horizontal matchParent. c padding: (BlInsets left: 10) ] ].
			list ]
]
