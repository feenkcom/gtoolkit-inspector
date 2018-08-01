*GToolkit-Inspector
gtBlocCodeGraphIn: aView
	<gtView: 40>
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
			view layout horizontalTree levelDistance: 200 "layered horizontalGap: 100" ]