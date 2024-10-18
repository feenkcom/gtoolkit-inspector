Extension { #name : #MCPatch }

{ #category : #'*GToolkit-Inspector' }
MCPatch >> gtOperationsTree [
	| classes classModifications |
	classes := (self operations collect: [ :each | each definition className ]) asSet asArray sort: #yourself ascending.
	^ classes collect: [ :eachClass |
		classModifications := self operations select: [ :each | each definition className = eachClass ].
		classModifications := classModifications sort: [ :each | each definition sortKey ] ascending.
		classModifications := classModifications collect: [ :each | each -> #() ].
		eachClass -> classModifications ]
]

{ #category : #'*GToolkit-Inspector' }
MCPatch >> gtViewOperationsIn: composite [
	<gtView>
	^ composite columnedList
		title: 'Operations';
		priority: 30;
		items: [ self operations ];
		column: 'Operation type' text: [ :each | each class name ];
		column: 'Icon' icon: [ :each | each icon ];
		column: 'Definition type' text: [ :each | each definition class name ];
		column: 'Definition summary' text: [ :each | each definition gtSummary ]
]

{ #category : #'*GToolkit-Inspector' }
MCPatch >> gtViewOperationsTreeIn: composite [
	<gtView>
	^ composite columnedTree
		title: 'Tree';
		priority: 35;
		tooltip: 'Operations grouped by class';
		items: [ self gtOperationsTree ];
		children: #value;
		column: 'Operation type'
			text: [ :each | each key isString ifTrue: [ each key ] ifFalse: [ each key class name ] ];
		column: 'Icon'
			icon: [ :each | 
				each key isString
					ifTrue: [ BrGlamorousVectorIcons transparent ]
					ifFalse: [ each key icon ] ];
		column: 'Definition type'
			text: [ :each | each key isString ifTrue: [ '' ] ifFalse: [ each key definition class name ] ];
		column: 'Definition summary'
			text: [ :each | each key isString ifTrue: [ '' ] ifFalse: [ each key definition gtSummary ] ];
		expandAll;
		send: #key
]
