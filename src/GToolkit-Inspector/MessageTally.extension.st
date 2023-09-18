Extension { #name : #MessageTally }

{ #category : #'*GToolkit-Inspector' }
MessageTally >> addReceiver: aMessageTally [
	receivers := receivers copyWith: aMessageTally
]

{ #category : #'*GToolkit-Inspector' }
MessageTally >> applyFilter: aGtMessageTallyFilter [
	^ aGtMessageTallyFilter filter: self
]

{ #category : #'*GToolkit-Inspector' }
MessageTally >> changeToOuterMethod [
	method := method method
]

{ #category : #'*GToolkit-Inspector' }
MessageTally >> children [
	^ self sonsOver: 0
]

{ #category : #'*GToolkit-Inspector' }
MessageTally >> displayIdentifierOn: aStream [
	class displayStringOn: aStream.
	self method methodClass ~~ class 
		ifTrue: [ aStream nextPut: $(; print: self method methodClass; nextPut: $) ].
	aStream 
		nextPutAll: '>>';
		store: self method selector
]

{ #category : #'*GToolkit-Inspector' }
MessageTally >> filterCopy [
	^ self copy filterPostCopy
]

{ #category : #'*GToolkit-Inspector' }
MessageTally >> filterPostCopy [
	receivers := Array new: 0.
	senders := nil
]

{ #category : #'*GToolkit-Inspector' }
MessageTally >> gtDisplayIdentifierOn: aStream [
	class displayStringOn: aStream.
	self method methodClass ~~ class 
		ifTrue: [ aStream nextPut: $(; print: self method methodClass; nextPut: $) ].
	aStream 
		nextPutAll: '>>';
		store: self method selector
]

{ #category : #'*GToolkit-Inspector' }
MessageTally >> gtDisplayOn: aStream [
	self gtDisplayIdentifierOn: aStream.
	aStream 
		nextPutAll: ' (';
		nextPutAll: self tally printString;
		nextPutAll: ')'
]

{ #category : #'*GToolkit-Inspector' }
MessageTally >> gtGroupedByMethodFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Top local tallies';
		priority: 11;
		stencil: [ 
			| grouped barChart tallies data maxTally aBarWidthScale aBarHeightScale |
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
			barChart barLabelAptitudeStencil: [ BrGlamorousLabelAptitude new glamorousRegularFont; fontSize: 10 ].
			barChart barWidthScale: aBarWidthScale.
			barChart barWidthData: [ :eachValue | eachValue localTally ].
			barChart barHeightScale: aBarHeightScale.
			barChart barHeightData: [ :eachGroup | eachGroup size * 2 ].
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
		highColor:
			(Color
				r: 216
				g: 55
				b: 62
				range: 255).
	^ (aView columnedTree)
		title: 'Tree';
		priority: 10;
		expandSuchThat: [ :aNode :aMessageTally | aMessageTally tally / (self tally max: 0.1) > 0.15 ];
		items: [ {self} ];
		children: [ :each | each children ];
		column: 'Method'
			do:
				[ :aColumn | 
					aColumn
						cellStencil:
								[ (BrLabel new)
										aptitude: BrGlamorousLabelAptitude new;
										addAptitude:
												(BrGlamorousWithContextMenuAptitude
														content:
															[ (BrGlamorousSimpleContextMenuContent new)
																items:
																		{'Gather'
																					->
																						[ :e | e phlow spawnObject: (self applyFilter: (GtGatherMessageTallyFilter forMethod: (e userData at: #method))) ]};
																yourself ]) ];
						dataBinder:
								[ :eachLabel :each | 
									eachLabel userData at: #method put: each method.
									eachLabel text: (each method gtDisplayString asRopedText glamorousRegularFont foreground: (normalizer value: each)) ] ];
		column: 'Percent'
			text:
				[ :each | 
				((each tally / (self tally max: 0.1) asFloat * 100 printShowingDecimalPlaces: 1) , '%') asRopedText glamorousRegularFont
					foreground: (normalizer value: each) ]
			width: 100;
		column: 'Tally'
			text: [ :each | each tally asString asRopedText glamorousRegularFont foreground: (normalizer value: each) ]
			width: 100
]

{ #category : #'*GToolkit-Inspector' }
MessageTally >> gtPreviewFor: aView [
	^ aView empty
]

{ #category : #'*GToolkit-Inspector' }
MessageTally >> gtRecursionSummaryMessagesTreeIn: aView [
	<gtView>
	
	^ aView forward
		title: 'Summarize recursion';
		priority: 12;
		object: [ self applyFilter: GtRecursionSummaryFilter new ];
		view: #gtMessagesTreeIn:
]

{ #category : #'*GToolkit-Inspector' }
MessageTally >> gtSourceFor: aView [
	<gtView>
	self method ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Source';
		priority: 20;
		object: [ self method method ];
		view: #gtSourceFor:
]

{ #category : #'*GToolkit-Inspector' }
MessageTally >> gtTextReportFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Text report';
		aptitude: BrGlamorousCodeEditorAptitude;
		priority: 60;
		text: [ String streamContents: [:s | self report: s ] ]
]

{ #category : #'*GToolkit-Inspector' }
MessageTally >> localTally [
	^ self children 
		inject: self tally
		into: [ :diff :each | diff - each tally ]
]

{ #category : #'*GToolkit-Inspector' }
MessageTally >> localTime [
	^ self children
		inject: self time 
		into: [ :diff :each | diff - each time ]
]

{ #category : #'*GToolkit-Inspector' }
MessageTally class >> on: aBlock [

	"This utility method constructs a tally object and returns it without
	triggering the construction of the default report"

	^ MessageTally new
		  spyEvery: 1 on: aBlock;
		  yourself
]

{ #category : #'*GToolkit-Inspector' }
MessageTally >> package [
	^ method package
]

{ #category : #'*GToolkit-Inspector' }
MessageTally >> setMethod: aCompiledMethod [
	method := aCompiledMethod
]
