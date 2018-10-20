Extension { #name : #GtExampleGroup }

{ #category : #'*GToolkit-Inspector' }
GtExampleGroup >> gtExamplesFor: aView [
	<gtView>
	^ aView explicit
		title: 'Examples';
		priority: 10;
		actionStencil: [ :tab |
			BrButton new 
				look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
				icon: BrGlamorousIcons play asElement;
				action: [
					self examples 
						do: [ :each | each ignoreTest ifFalse: [ each run ] ] 
						displayingProgress: 'Running examples ...'.
					tab parentTabGroup 	
						allChildrenBreadthFirstDetect: [ :aChild | aChild phlow isViewContent ] 
						ifFound: [ :aList | aList children first dataSource notifyChanged ] 
						ifNone: [self error: 'I should have found a view content element, but I did not.']  ] ];
		stencil: [ | theExamples aList |
			theExamples := self examples.
			aList := BrColumnedList new display: theExamples.
			aList addEventHandler: (GtInspectorListToSelectHandler new transformation: [ :each | 
				(each isKindOf: GtExampleWithResult)
					ifTrue: [ each example ]
					ifFalse: [ each ] ]).
			aList column
				title: 'Icon' translated;
				stencil: [ :eachExample :anIndex | | anElement |
					anElement := eachExample icon asElement.
					anElement
						constraintsDo: [ :c | 
							c padding: (BlInsets top: 2) ];
						when: BlClickEvent do: [ :anEvent | 
							eachExample run.
							anElement background: eachExample icon.
							anEvent consumed: true.
							anElement fireEvent: (GtPhlowObjectToSpawn new object: eachExample result returnValue; sourceElement: anElement) ] ].
			aList column
				title: 'Class' translated;
				stencil: [ :eachExample :anIndex | 
					(BrListLabelStencil matchParent: eachExample example methodClass name) asElement
						constraintsDo: [ :c | c padding: (BlInsets left: 10) ] ].
			aList column
				title: 'Selector' translated;
				stencil: [ :eachExample :anIndex | 
					(BrListLabelStencil matchParent: eachExample example selector asString) asElement
						constraintsDo: [ :c | c padding: (BlInsets left: 10) ] ].
			aList column
				title: 'Result' translated;
				stencil: [ :eachExample :anIndex | 
					(BrListLabelStencil matchParent: eachExample resultOrErrorName) asElement
						constraintsDo: [ :c | c padding: (BlInsets left: 10) ] ].
			aList
			]
]

{ #category : #'*GToolkit-Inspector' }
GtExampleGroup >> gtMapFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Map';
		priority: 90;
		painting: [ :mondrian | self paintMapWith: mondrian ]
]
