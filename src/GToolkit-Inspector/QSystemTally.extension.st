Extension { #name : #QSystemTally }

{ #category : #'*GToolkit-Inspector' }
QSystemTally >> children [
	^ self sonsOver: 0
]

{ #category : #'*GToolkit-Inspector' }
QSystemTally >> gtMessagesTreeIn: aView [
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

{ #category : #'*GToolkit-Inspector' }
QSystemTally >> gtSourceFor: aView [
	<gtView>
	^ self method ifNotNil: [
		(self method method gtSourceFor: aView) priority: 20]
]
