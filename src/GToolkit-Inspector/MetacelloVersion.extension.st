Extension { #name : #MetacelloVersion }

{ #category : #'*GToolkit-Inspector' }
MetacelloVersion >> gtPackagesFor: aView [
	<gtView: 20>
	^ aView explicit
		title: 'Packages';
		stencil: [ BrSimpleList new display: [ self packages ] ]
]

{ #category : #'*GToolkit-Inspector' }
MetacelloVersion >> gtProjectMapFor: aView [
	<gtView: 40>
	^ aView mondrian
		title: 'Project map';
		painting: [ :mondrian |
			mondrian
				nodes 
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
"							curvatureFraction: 0.1;"
							toHead: (BlArrowheadSimpleArrow new
								border: (BlBorder builder paint: (Color gray alpha: 0.5); width: 2; build))  ];
					fromRightCenter;
					toLeftCenter;
					connectFrom: #yourself 
					toAll: [:each | each projects collect: #version].
			mondrian layout horizontalTree nodeDistance: 30; levelDistance: 10 ]
]

{ #category : #'*GToolkit-Inspector' }
MetacelloVersion >> gtProjectsFor: aView [
	<gtView: 30>
	^ aView explicit
		title: 'Projects';
		stencil: [ BrSimpleList new display: [ self projects ] ]
]
