Extension { #name : 'BlDevScripterStep' }

{ #category : '*GToolkit-Inspector' }
BlDevScripterStep >> gtStepsMondrianTreeFor: aView [
	<gtView>
	
	^ aView mondrian
		title: 'Steps';
		priority: 2;
		painting: [ :aMondrian | self paintTreeWith: aMondrian ]
]

{ #category : '*GToolkit-Inspector' }
BlDevScripterStep >> gtStepsTreeFor: aView [
	<gtView>
	
	^ aView columnedTree
		title: 'Steps In Tree';
		priority: 2.5;
		expandUpTo: 3;
		items: [ { self } ];
		children: [ :aStep | aStep steps ];
		column: 'Status' translated 
			icon: [ :each | 
				BrLabel new text: each stateName; aptitude: (BrGlamorousLabelAptitude new);
					geometry: (BlRoundedRectangleGeometry cornerRadius: 2); background: each stateColor ]
			weight: 1;
		column: 'Step' text: #label weight: 4;
		column: 'Target' text: #target weight: 2
]

{ #category : '*GToolkit-Inspector' }
BlDevScripterStep >> paintTreeWith: view [
	view nodes
		shape: [ :each | 
			BrDevScripterStepElement newFromStep: each ];
		with: (self withDeepCollect: #steps).
	view edges
		shape: [ :each | BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.5) width: 1 ) ];
		fromRightCenter;
		toLeftCenter;
		connectToAll: #steps.
	view layout custom: (GtGradWestHierarchicalLayout new alignment: GtGradHierarchicalLayoutRootAlignment new)
]
