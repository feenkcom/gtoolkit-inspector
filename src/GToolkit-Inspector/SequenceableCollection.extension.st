Extension { #name : #SequenceableCollection }

{ #category : #'*GToolkit-Inspector' }
SequenceableCollection >> gtBoxesFor: aView [
	<gtView>
	^ aView explicit
		title: 'Boxes';
		priority: 90;
		stencil: [
		| container |
		container := BlElement new
			constraintsDo: [:c | 
				c vertical fitContent.
				c horizontal matchParent ];
			layout: BlFlowLayout new;
			padding: (BlInsets all: 10).
			self withIndexDo: [:each :i | 
				container addChild: (BlElement new 
					margin: (BlInsets top: -1 left: -1);
					constraintsDo: [:c | c vertical exact: 50. c horizontal exact: 50];
					border: (BlBorder paint: Color gray);
					layout: BlLinearLayout new;
					padding: (BlInsets all: 10);
					addChild: (BrLabel new 
						text: i asString; 
						look: (BrGlamorousLabelLook new foreground: Color gray; fontSize: 10);
						constraintsDo: [:c | c ignoreByLayout ]);
						addChild: (BlElement new 
							constraintsDo: [:c | 
								c horizontal matchParent.
								c vertical matchParent];
							layout: BlLinearLayout new alignCenter;
							addChild: (BrLabel new 
								text: each gtDisplayString; 
								look: BrGlamorousLabelLook;
								constraintsDo: [:c | 
									c horizontal fitContent.
									c vertical fitContent.
									c linear vertical alignCenter.
									c linear horizontal alignCenter])))].
		container asScrollableElement ]
		
]

{ #category : #'*GToolkit-Inspector' }
SequenceableCollection >> gtItemsFor: aView [
	| aList |

	aList := aView columnedList
		title: 'Items' translated;
		priority: 50;
		items: [ self ].

	aList column
		title: 'Index' translated;
		width: 30;
		item: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray].
	
	aList column
		title: 'Item' translated;
		item: [ :eachItem :eachIndex | eachItem ];
		itemFormat: [ :eachItem | eachItem gtDisplayText ].
	
	^ aList
]
