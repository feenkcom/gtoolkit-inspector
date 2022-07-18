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
												text: each gtDisplayString;
												constraintsDo: [ :c | 
													c horizontal fitContent.
													c vertical fitContent.
													c linear vertical alignCenter.
													c linear horizontal alignCenter ]))) ].
			container asScrollableElement ]
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
