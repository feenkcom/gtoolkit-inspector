*GToolkit-Inspector
gtBlocCodeGraphIn: aView
	<gtView: 40>
	^ aView mondrian
		title: '_Code graph';
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
					editorElement constraintsDo: [ :c |
					    c horizontal matchParent.
					    c vertical matchParent ].
					editorElement editor: editor.
					"editorElement
						addEventHandlerOn: BlClickEvent do: [ :anEvent | presentation selection: each ]."
					editorElement ];
				with: (self withDeepCollect: #directDependencies) asSet.
			view edges 
				fromRightCenter; toLeftCenter;
				connectToAll: #directDependencies.
			view layout horizontalDominanceTree layered horizontalGap: 100 ]