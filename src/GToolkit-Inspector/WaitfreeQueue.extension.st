Extension { #name : #WaitfreeQueue }

{ #category : #'*GToolkit-Inspector' }
WaitfreeQueue >> gtGraphFor: aView [
	<gtView> 

	^aView mondrian 
		title: 'Graph' translated;
		painting: [ :mondrian | self paintGraphWith: mondrian ]
]

{ #category : #'*GToolkit-Inspector' }
WaitfreeQueue >> gtItemsFor: aView [

	<gtView>
	| aList |
	aList := aView columnedList
		         title: 'Items' translated;
		         priority: 50;
		         items: [ self itemArray ].

	aList column
		title: 'Index' translated;
		width: 30;
		item: [ :eachItem :eachIndex | 
			eachIndex asRopedText foreground: Color gray ].

	aList column
		title: 'Object' translated;
		item: [ :eachItem :eachIndex | 
			eachItem object == dummy
				ifTrue: [ '<Zombie>' ]
				ifFalse: [ eachItem object ] ];
		text: [ :eachItem | eachItem asString ].

	^ aList
]

{ #category : #'*GToolkit-Inspector' }
WaitfreeQueue >> paintGraphWith: view [
	| itemArray |
	itemArray := self itemArray.
	view nodes 
		stencil: [ :node | 
				BlTextElement new 
						text: 'dummy' asRopedText glamorousRegularFont;
						padding: (BlInsets all: 5) ];
		with: dummy asOrderedCollection;
		stencil: [ :node | 
				BlTextElement new 
						text: node gtDisplayString asRopedText glamorousRegularFont;
						padding: (BlInsets all: 5) ];
		with: itemArray;
		stencil: [ :node | 
				BlTextElement new 
						text: ((node gtDisplayString asRopedText glamorousRegularFont foreground: Color blue));
						padding: (BlInsets all: 5) ];
		with: (itemArray collect: #object) asIdentitySet.
	view edges 
		fromCenterBottom;
		toCenterTop;
		stencil: [ :each | 
			BlParabollaArcElement new 
				border: (BlBorder paint: (Color black alpha: 0.4) width: 2);
				curvatureFraction: 0.2;
				toHead: (BlArrowheadSimpleArrow new
					border: (BlBorder builder paint: (Color black alpha: 0.4); width: 2; build))];
		connect: (itemArray, dummy asOrderedCollection) from: #yourself to: #next;
		stencil: [ :each | 
			BlParabollaArcElement new 
				border: (BlBorder paint: (Color blue alpha: 0.8) width: 2);
				curvatureFraction: 0.2;
				toHead: (BlArrowheadSimpleArrow new
					border: (BlBorder builder paint: (Color blue alpha: 0.8); width: 2; build))];
		connect: itemArray from: #yourself to: #object.
	view layout dominanceTree levelDistance: 30 "custom: GtGradNorthHierarchicalLayout new"
		"custom: GtGraphDominanceTreeLayout new".
]
