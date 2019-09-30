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
				stencil: [ :each | BrColumnCellLabelStencil matchParent: each name ].
			list column 
				title: 'Package';
				stencil: [ :each | BrColumnCellLabelStencil matchParent: each package name ].
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
				stencil: [ :each | BrColumnCellLabelStencil matchParent: each name ].
			list column 
				title: 'Package';
				stencil: [ :each | BrColumnCellLabelStencil matchParent: each package name ].
			list
			].
		
]

{ #category : #'*GToolkit-Inspector' }
Class >> gtDefinitionFor: aView [
	<gtView>
	^ aView textEditor  
		title: 'Definition';
		priority: 1;
		styler: BrRBTextStyler new;
		look: BrGlamorousCodeEditorLook new;
		text: [ self definition asRopedText ].
]

{ #category : #'*GToolkit-Inspector' }
Class >> gtExamplesFor: aView [
	<gtView>
	
	^ (GtExampleGroup withAll: self gtExamplesAll)
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
