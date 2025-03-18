Extension { #name : #SequenceableCollection }

{ #category : #'*GToolkit-Inspector' }
SequenceableCollection >> gtBoxesFor: aView [
	<gtView>
	self isCollection ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Boxes';
		priority: 90;
		actionUpdateButtonTooltip: 'Update boxes';
		stencil: [ | container |
			container := BlElement new
					constraintsDo: [ :c | 
						c vertical fitContent.
						c horizontal matchParent ];
					layout: BlFlowLayout new;
					padding: (BlInsets all: 10).
			self
				withIndexDo: [ :each :i | 
					container
						addChild: (BlElement new
								margin: (BlInsets top: -1 left: -1);
								constraintsDo: [ :c | 
									c vertical exact: 50.
									c horizontal fitContent ];
								border: (BlBorder paint: Color gray);
								layout: BlLinearLayout new;
								padding: (BlInsets all: 10);
								addChild: (BrLabel new
										text: i asString;
										aptitude: (BrGlamorousLabelAptitude new
												foreground: Color gray;
												fontSize: 10);
										constraintsDo: [ :c | c ignoreByLayout ]);
								addChild: (BlElement new
										constraintsDo: [ :c | 
											c horizontal matchParent.
											c vertical matchParent ];
										layout: BlLinearLayout new alignCenter;
										addChild: (BrLabel new
												text: each printString;
												aptitude: BrGlamorousLabelAptitude;
												when: BlClickEvent 
													do: [ :event | event target phlow spawnObject: each ];
												constraintsDo: [ :c | 
													c horizontal fitContent.
													c vertical fitContent.
													c linear vertical alignCenter.
													c linear horizontal alignCenter ]))) ].
			container asScrollableElement ]
]

{ #category : #'*GToolkit-Inspector' }
SequenceableCollection >> gtCreateDetailsViewSourceFor: aGtViewCreator [
	<gtViewCreator>
	| template bindings |
	(self notEmpty and: [ self first isAssociation ])
		ifFalse: [ ^ aGtViewCreator empty ].
	
	aGtViewCreator
		title: 'Details'.
		
	template := '{viewSelector} aView
	<gtView>
	{optionalNilCheck}
	^ aView columnedList 
		title: ''{viewTitle}'';
		items: [ {objectSource} ];
		column: ''Property'' text: [ :each | each key gtDisplayString asRopedText foreground: Color gray ];
		column: ''Value'' text: [:each | each value gtDisplayString ];
		send: [ :each | each value ]'.
		
	bindings := {
		'viewSelector' -> aGtViewCreator newSelector.
		'viewTitle' -> aGtViewCreator title.
		'optionalNilCheck' -> (aGtViewCreator variable
				ifNil: [ '' ]
				ifNotNil: [ :aVariable | aVariable, ' ifNil: [ ^aView empty ].'] ).
		'objectSource' -> aGtViewCreator objectSource
	} asDictionary.
	
	aGtViewCreator
		source: (template format: bindings)
]

{ #category : #'*GToolkit-Inspector' }
SequenceableCollection >> gtCreateViewSourceFor: aGtViewCreator [
		<gtViewCreator>
	
	aGtViewCreator
		source: (String
				streamContents: [ :stream | 
					stream << aGtViewCreator newSelector << ' aView' << String lf << '	<gtView>'
						<< String lf.
					aGtViewCreator variable
						ifNotNil: [ :v | stream << '	' << v << ' ifNil: [ ^aView empty ].' << String lf ].
					stream
						<< '	^ aView columnedList
		title: ''' << aGtViewCreator title
						<< ''';
		items: [' << aGtViewCreator objectSource
						<< '];
		column: ''Index'' 
			text: [ :each :index | index gtDisplayString ] 
			width: 45;
		column: ''Value'' text: [:each | each gtDisplayString ]' ])
]

{ #category : #'*GToolkit-Inspector' }
SequenceableCollection >> gtItemsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Items';
		priority: 50;
		items: [ self ];
		actionUpdateButtonTooltip: 'Update item list';
		column: 'Index' 
			text: [ :eachItem :eachIndex | 
				eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Item' 
			text: [ :eachItem | eachItem gtDisplayText ].
]
