Extension { #name : #MessageTally }

{ #category : #'*GToolkit-Inspector' }
MessageTally >> gtGroupedByMethodFor: aView [
	<gtView>
	| grouped aPlotter barChart |
	^ aView explicit
		title: 'By method';
		priority: 10;
		stencil: [
grouped := (self deepCollect: #children) groupedBy: #method.

aPlotter := GtPlotter new.

	barChart := aPlotter horizontalBarChart.
	barChart barStencil: [
		BlElement new
			geometry: BlStadium new;
			margin: (BlInsets top: 4 bottom: 4);
			background: (Color red alpha: 0.5)
	].
	barChart barWidthScale: (GtPlotterLinearScale new
		domainFrom: 0 to: (grouped associations max: [ :assoc | assoc value sum: #tally ])).
	barChart barHeightScale: (GtPlotterLinearScale new
		domainFrom: 0 to: (grouped associations max: [ :assoc | assoc value size ]);
		rangeFrom: 10 to: 50).
	barChart ticks: 2.
	barChart barLabelFormat: [ :assoc | assoc key gtDisplayString asRopedText glamorousRegularFont fontSize: 10].
	barChart barWidthData: [ :assoc | assoc value sum: #tally ].
	barChart barHeightData: [ :assoc | assoc value size ].
	barChart with: (grouped associations sorted: [:a :b | (a value sum: #tally) > (b value sum: #tally ) ]).

aPlotter root ]

]

{ #category : #'*GToolkit-Inspector' }
MessageTally >> gtMessagesTreeIn: aView [
	<gtView>
	| methods normalizer |
	methods := self withDeepCollect: #children.
	normalizer := BrColorLinearNormalizer 
						inContext: methods 
						withCommand: #tally 
						lowColor: Color gray 
						highColor: Color red.
	^ (aView tree)
		title: 'Tree';
		priority: 10;
		expandUpTo: 3;
		items: [ { self } ];
		children: [ :each | each children ];
		itemFormat: [ :each | 
			each gtDisplayString asRopedText foreground: (normalizer value: each)]		
]

{ #category : #'*GToolkit-Inspector' }
MessageTally >> gtSourceFor: aView [
	<gtView>
	^ self method ifNotNil: [
		(self method gtSourceFor: aView) priority: 20]
]

{ #category : #'*GToolkit-Inspector' }
MessageTally >> gtTextReportFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Text report';
		look: BrGlamorousCodeEditorLook new;
		priority: 60;
		text: [ String streamContents: [:s | self report: s ] ]
]
