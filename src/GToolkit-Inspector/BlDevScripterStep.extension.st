Extension { #name : #BlDevScripterStep }

{ #category : #'*GToolkit-Inspector' }
BlDevScripterStep >> gtPropertiesFor: aView [
	<gtView>
	self properties ifNil: [ ^ aView empty ].
	^ (self properties gtPropertiesFor: aView) priority: 90
]

{ #category : #'*GToolkit-Inspector' }
BlDevScripterStep >> gtReferenceFor: aView [
	<gtView>
	self reference ifNil: [ ^ aView empty ].
	^ (self reference gtReferenceFor: aView)
		priority: 5
]

{ #category : #'*GToolkit-Inspector' }
BlDevScripterStep >> gtScreenshotFor: aView [
	<gtView>
	self properties ifNil: [ ^ aView empty ].
	^ self properties gtScreenshotFor: aView
]

{ #category : #'*GToolkit-Inspector' }
BlDevScripterStep >> gtStepsMondrianTreeFor: aView [
	<gtView>
	
	self steps
		ifEmpty: [ ^ aView empty ].
	
	^ aView mondrian
		title: 'Steps';
		priority: 2;
		painting: [ :aMondrian | self paintTreeWith: aMondrian ]
]

{ #category : #'*GToolkit-Inspector' }
BlDevScripterStep >> gtStepsTreeFor: aView [
	<gtView>
	
	| aTotalDuration |
	self steps
		ifEmpty: [ ^ aView empty ].
	
	^ aView columnedTree
		title: 'Steps in tree';
		priority: 2.5;
		expandUpTo: 3;
		items: [ 
			aTotalDuration := self leavesStepExecutionTotalDuration asMicroseconds.
			{ self } ];
		children: [ :aStep | aStep steps ];
		column: 'Status' translated 
			icon: [ :each | 
				BrLabel new text: each stateName; aptitude: (BrGlamorousLabelAptitude new);
					geometry: (BlRoundedRectangleGeometry cornerRadius: 2); background: each stateColor ]
			weight: 1;
		column: 'Step' text: #label weight: 4;
		column: 'Target' text: #target weight: 2;
		column: 'Duration' 
			stencil: [ :aStep | 
				| playTime pulseTime |
				BrHorizontalPane new 
					hMatchParent;
					vExact: 8;
					addAptitude: (BrGlamorousWithTooltipAptitude content: [ 
						BrHorizontalGrid new 
							fitContent;
							padding: (BlInsets all: 5);
							columnCount: 2;
							addChild: (BrLabel new
								aptitude: BrGlamorousLabelAptitude;
								text: 'Play time:');
							addChild: (BrLabel new
								aptitude: BrGlamorousLabelAptitude;
								text: aStep leavesStepExecutionPlayDuration humanReadablePrintString);
							addChild: (BrLabel new
								aptitude: BrGlamorousLabelAptitude;
								text: 'Pulse time:');
							addChild: (BrLabel new
								aptitude: BrGlamorousLabelAptitude;
								text: aStep leavesStepExecutionPulseDuration humanReadablePrintString);
							addChild: (BrLabel new
								aptitude: BrGlamorousLabelAptitude;
								text: 'Total time:');
							addChild: (BrLabel new
								aptitude: BrGlamorousLabelAptitude;
								text: aStep leavesStepExecutionTotalDuration humanReadablePrintString)
					]);
					addChild: (BrFrame new
						background: BrGlamorousColors  pressedButtonBorderColor;
						matchParent;
						constraintsDo: [ :c | 
							c linear weight: (playTime := (aStep leavesStepExecutionPlayDuration asMicroseconds max: 1))
						]);
					addChild: (BrFrame new
						background: BrGlamorousColors failureBorderColor;
						matchParent;
						constraintsDo: [ :c | 
							c linear weight: (pulseTime := (aStep leavesStepExecutionPulseDuration asMicroseconds) max: 1)
						]);
					addChild: (BrFrame new
						background: BlBackground transparent ;
						matchParent;
						constraintsDo: [ :c | 
							c linear weight: ((aTotalDuration - playTime - pulseTime) max: 1)
						]) ] 
			width: 200;
		column: 'Pulses' text: [ :aStep | aStep properties stepExecution 
			ifNotNil: [ :aProperty | aProperty numberOfPulses ifNil: [ '' ] ] 
			ifNil: [ '' ] ] width: 50
]

{ #category : #'*GToolkit-Inspector' }
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
