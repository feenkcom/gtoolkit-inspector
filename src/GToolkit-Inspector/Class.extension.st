Extension { #name : #Class }

{ #category : #'*GToolkit-Inspector' }
Class >> gtAllReferencesFor: aView [
	<gtView>
	
	^ aView explicit 
		title: 'References';
		priority: 19;
		stencil: [
			| list |
			list := BrColumnedList new 
				display: [ 
					(SystemNavigation default allReferencesTo: self binding) 
						sorted: [ :x :y | x name < y name ] ].
			list addEventHandler: GtInspectorListToSelectHandler new.
			list column 
				title: 'Method';
				stencil: [ :each | BrListLabelStencil matchParent: each name ].
			list column 
				title: 'Package';
				stencil: [ :each | BrListLabelStencil matchParent: each package name ].
			list
			].
		
]

{ #category : #'*GToolkit-Inspector' }
Class >> gtAllReferencesOutsideFor: aView [
	<gtView>
	^ aView explicit 
		title: 'All Ref Outside';
		priority: 41;
		stencil: [
			| list |
			list := BrColumnedList new display: [ ((SystemNavigation default allReferencesTo: self binding) 
							reject: [ :method | method package name == self package name ])
						sorted: [ :x :y | x name < y name ] ].
			list column 
				title: 'Method';
				stencil: [ :each | BrListLabelStencil matchParent: each name ].
			list column 
				title: 'Package';
				stencil: [ :each | BrListLabelStencil matchParent: each package name ].
			list
			].
		
]

{ #category : #'*GToolkit-Inspector' }
Class >> gtDefinitionFor: aView [
	<gtView>
	^ aView explicit  
		title: 'Definition';
		priority: 1;
		stencil: [ 
		| text styler editor editorElement |

		text := self definition asRopedText" readonly".

		text attributes: {
		BrFontGenericFamilyAttribute monospace beNotOverwritableByStyler.
		(BrFontSizeAttribute size: 14) beNotOverwritableByStyler }.

		styler := BrRBTextStyler new.

		editor := BrTextEditor new.
		editor styler: styler.
		editor text: text.

		editorElement := BrEditorElement new.
		editorElement constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].

		editorElement editor: editor.

		editorElement].
]

{ #category : #'*GToolkit-Inspector' }
Class >> gtGTExamplesFor: aView [
	<gtView>
	
	^ (GtExampleGroup new examples: self gtExamples)
			gtExamplesFor: aView
]

{ #category : #'*GToolkit-Inspector' }
Class >> gtInstanceVariablesFor: aView [
	<gtView>
	^ aView explicit
		title: 'InstVars';
		priority: 5;
		stencil: [
			| list |
			list := BrColumnedList new display: [ self class allInstVarNames sorted collect: [ :each | each -> (self instVarNamed: each) ] ].
			list addEventHandler: (GtInspectorListToSelectHandler new transformation: [:assoc | assoc value ]).
			list column
				title: 'Variable';
				stencil: [ :each | 
					| label |
					label := BrListLabelStencil fitContent: each key.
					label constraintsDo: [ :c | c horizontal exact:200 ] ].
			list column
				title: 'Value';
				stencil: [ :each | BrListLabelStencil matchParent: each value ].
			list ]
]

{ #category : #'*GToolkit-Inspector' }
Class >> gtMethodsFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Methods' translated;
		priority: 2;
		stencil: [
			| list |
			list := BrColumnedList new display: [ 
				(self methods collect: #asRingDefinition) 
					sorted: [ :x :y | x selector < y selector ] ].
			list addEventHandler: GtInspectorListToSelectHandler new.
			list column 
				title: 'Selector' translated;
				stencil: [ :each :rowIndex | (BrListLabelStencil matchParent: each selector) asElement ].
			list column 
				title: 'Class' translated;
				stencil: [ :each :rowIndex  | (BrListLabelStencil fitContent: each methodClass name) asElement ].
			list ]
]

{ #category : #'*GToolkit-Inspector' }
Class >> gtPillarCommentFor: aView [
	<gtView>
	^ aView explicit
		title: 'Comment';
		priority: 10;
		stencil: [ GtDocumenter editorForText: self comment ];
		actionStencil: [ :tab | 
			BrButton new 
				look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
				icon: BrGlamorousIcons accept asElement;
				action: [ self comment: tab viewContentElement editor text asString ] ]
]
