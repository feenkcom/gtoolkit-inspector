Extension { #name : #MessageTally }

{ #category : #'*GToolkit-Inspector' }
MessageTally >> gtGroupedByMethodFor: aView [
	<gtView>
	| grouped barChart tallies data maxTally aBarWidthScale aBarHeightScale|
	^ aView explicit
		title: 'By method';
		priority: 10;
		stencil: [ 
			tallies := self deepCollect: #children.
			data := GtPlotterDataGroup new values: tallies.
			grouped := data 
				groupedBy: #method 
				sorted: [:a :b | (a value sumNumbers: #tally) > (b value sumNumbers: #tally)] 
				decorated: [ :each |  {
					GtPlotterDataGroupWithLabel new label: (each gtDisplayString).
					GtPlotterDataGroupWithColor new color: (Color r: 216 g: 55 b: 62 range: 255)} ].
			maxTally := data inject: 0 intoValues: [ :anAmount :eachValue | anAmount max: (eachValue tally) ].
			aBarWidthScale := GtPlotterLinearScale new domainFrom: 0 to: maxTally.
			aBarHeightScale := GtPlotterLinearScale new
		domainFrom: 0 to: (grouped entities max: #size);
		rangeFrom: 5 to: 100.
			barChart := GtPlotterHorizontalBarChart new.
			barChart withAdjacentBars.
			barChart groupSpacing: 10.
			barChart barLabelWidth: 300.
			barChart barLabelLookStencil: [ BrGlamorousLabelLook new glamorousRegularFont; fontSize: 10 ].
			barChart barWidthScale: aBarWidthScale.
			barChart barWidthData: [ :eachValue | eachValue tally ].
			barChart barHeightScale: aBarHeightScale.
			barChart barHeightData: [ :eachGroup | eachGroup size * 5 ].
			barChart amountOfTicks: 4.
			barChart with: grouped.
			barChart asElement	 ]
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
