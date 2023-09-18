Extension { #name : #SmalltalkImage }

{ #category : #'*GToolkit-Inspector' }
SmalltalkImage >> gtExamplesContainedFor: aView [
	<gtView>
	^ aView explicit
		title: 'Examples';
		priority: 10;
		stencil: [ | aList |
			aList := BrColumnedList new
				items:
					(self gtExamplesContained
						collect: [ :each | each asExampleWithResult ]).
			aList
				addEventHandler:
					(GtPhlowListToSelectHandler new
						transformation: [ :each | 
							(each isKindOf: GtExampleWithResult)
								ifTrue: [ each example ]
								ifFalse: [ each ] ]).
			aList column
				title: 'Icon' translated;
				stencil: [ :eachExample :anIndex | 
					| anElement |
					anElement := eachExample icon asElement.
					anElement
						constraintsDo: [ :c | c padding: (BlInsets top: 2) ];
						when: BlClickEvent
							do: [ :anEvent | 
							eachExample run.
							anElement background: eachExample icon.
							anEvent consumed: true.
							anElement phlow spawnObject: eachExample result returnValue ] ].
			aList column
				title: 'Class' translated;
				stencil: [ :eachExample :anIndex | 
					(BrColumnCellLabelStencil
						matchParent: eachExample example methodClass name) asElement
						constraintsDo: [ :c | c padding: (BlInsets left: 10) ] ].
			aList column
				title: 'Selector' translated;
				stencil: [ :eachExample :anIndex | 
					(BrColumnCellLabelStencil
						matchParent: eachExample example selector asString) asElement
						constraintsDo: [ :c | c padding: (BlInsets left: 10) ] ].
			aList column
				title: 'Result' translated;
				stencil: [ :eachExample :anIndex | 
					(BrColumnCellLabelStencil matchParent: eachExample resultOrErrorName)
						asElement constraintsDo: [ :c | c padding: (BlInsets left: 10) ] ].
			aList ]
]
