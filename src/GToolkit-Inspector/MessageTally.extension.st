Extension { #name : 'MessageTally' }

{ #category : '*GToolkit-Inspector' }
MessageTally >> gtGroupedByMethodFor: aView [
	<gtView>
	| grouped barChart tallies data maxTally aBarWidthScale aBarHeightScale|
	^ aView explicit
		title: 'Top local tallies';
		priority: 11;
		stencil: [ 
			tallies := self deepCollect: #children.
			data := GtPlotterDataGroup new values: tallies.
			grouped := data 
				groupedBy: #method 
				sorted: [:a :b | (a value sumNumbers: #localTally) > (b value sumNumbers: #localTally)] 
				decorated: [ :each |  {
					GtPlotterDataGroupWithLabel new label: (each gtDisplayString).
					GtPlotterDataGroupWithColor new color: (Color r: 216 g: 55 b: 62 range: 255)} ].
			maxTally := data inject: 0 intoValues: [ :anAmount :eachValue | anAmount max: (eachValue localTally) ].
			aBarWidthScale := GtPlotterLinearScale new domainFrom: 0 to: maxTally.
			aBarHeightScale := GtPlotterLinearScale new
		domainFrom: 0 to: (grouped entities max: #size);
		rangeFrom: 2 to: 50.
			barChart := GtPlotterHorizontalBarChart new.
			barChart withAdjacentBars.
			barChart groupSpacing: 10.
			barChart barLabelWidth: 300.
			barChart barLabelLookStencil: [ BrGlamorousLabelAptitude new glamorousRegularFont; fontSize: 10 ].
			barChart barWidthScale: aBarWidthScale.
			barChart barWidthData: [ :eachValue | eachValue localTally ].
			barChart barHeightScale: aBarHeightScale.
			barChart barHeightData: [ :eachGroup | eachGroup size * 2 ].
			barChart amountOfTicks: 4.
			barChart with: grouped.
			barChart asElement	 ]
]

{ #category : '*GToolkit-Inspector' }
MessageTally >> gtMessagesTreeIn: aView [
	<gtView>
	| methods normalizer |
	methods := self withDeepCollect: #children.
	normalizer := BrColorLinearNormalizer
		inContext: methods
		withCommand: #tally
		lowColor: Color gray
		highColor:
			(Color
				r: 216
				g: 55
				b: 62
				range: 255).
	^ aView columnedTree
		title: 'Tree';
		priority: 10;
		expandSuchThat: [ :aNode :aMessageTally |
			(aMessageTally tally / (self tally max: 0.1)) > 0.15 ];
		items: [ {self} ];
		children: [ :each | each children ];
		column: 'Method'
			text: [ :each | 
			each method gtDisplayString asRopedText glamorousRegularFont
				foreground: (normalizer value: each) ];
		column: 'Percent'
			text: [ :each | 
			((each tally / (self tally max: 0.1) asFloat * 100
				printShowingDecimalPlaces: 1) , '%') asRopedText
				glamorousRegularFont foreground: (normalizer value: each) ]
			width: 100;
		column: 'Tally'
			text: [ :each | 
			each tally asString asRopedText glamorousRegularFont
				foreground: (normalizer value: each) ]
			width: 100
]

{ #category : '*GToolkit-Inspector' }
MessageTally >> gtSourceFor: aView [
	<gtView>
	^ self method ifNotNil: [
		(self method gtSourceFor: aView) priority: 20]
]

{ #category : '*GToolkit-Inspector' }
MessageTally >> gtTextReportFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Text report';
		aptitude: BrGlamorousCodeEditorAptitude;
		priority: 60;
		text: [ String streamContents: [:s | self report: s ] ]
]
