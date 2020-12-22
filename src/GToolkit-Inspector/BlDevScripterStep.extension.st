Extension { #name : #BlDevScripterStep }

{ #category : #'*GToolkit-Inspector' }
BlDevScripterStep >> gtStepsMondrianTreeFor: aView [
	<gtView>
	
	^ aView mondrian
		title: 'Steps';
		priority: 2;
		painting: [ :aMondrian | self paintTreeWith: aMondrian ]
]

{ #category : #'*GToolkit-Inspector' }
BlDevScripterStep >> gtStepsTreeFor: aView [
	<gtView>
	
	^ aView columnedTree
		title: 'Steps In Tree';
		priority: 2.5;
		expandUpTo: 3;
		items: [ { self } ];
		children: [ :aStep | aStep steps ];
		column: 'Status' text: [ :aStep | aStep stateName asRopedText foreground: aStep stateColor ] weight: 2;
		column: 'Step' item: #label weight: 4;
		column: 'Target' item: #target weight: 1
]

{ #category : #'*GToolkit-Inspector' }
BlDevScripterStep >> paintTreeWith: view [
	view nodes
		shape: [ :each | 
			BrDevScripterStepElement newFromStep: each ];
		with: (self withDeepCollect: #steps).
	view edges
		shape: [ :each | BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.5) width: 1 ) ];
		connectToAll: #steps.
	view layout custom: (GtGradNorthHierarchicalLayout new)
]
