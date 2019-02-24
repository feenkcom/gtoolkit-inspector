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
		BlFontGenericFamilyAttribute monospace beNotOverwritableByStyler.
		(BlFontSizeAttribute size: 14) beNotOverwritableByStyler }.

		styler := BrRBTextStyler new.

		editor := BrTextEditor new.
		editor styler: styler.
		editor text: text.

		editorElement := BrEditorElement new.
		editorElement constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c padding: (BlInsets all: 10) ].

		editorElement editor: editor.

		editorElement].
]

{ #category : #'*GToolkit-Inspector' }
Class >> gtExamplesFor: aView [
	<gtView>
	
	^ (GtExampleGroup withAll: self gtExamples)
			gtExamplesFor: aView
]

{ #category : #'*GToolkit-Inspector' }
Class >> gtInstanceVariablesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'InstVars';
		priority: 5;
		items: [ self class allInstVarNames sorted
				collect: [ :each | each -> (self instVarNamed: each) ] ];
		column: 'Variable'
			do: [ :aColumn | aColumn item: [ :each | each key ] ];
		column: 'Value'
			do: [ :aColumn | aColumn item: [ :each | each value ] ]
]

{ #category : #'*GToolkit-Inspector' }
Class >> gtMethodsFor: aView [
	<gtView>
	^ aView explicit
		title: 'Methods' translated;
		priority: 2;
		stencil: [ (GtClassMethodsCoder forClass: self) asElement ]
]
