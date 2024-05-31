Extension { #name : #Duration }

{ #category : #'*GToolkit-Inspector' }
Duration >> gtPreviewFor: aView [
	<gtView>
	^ aView explicit
		title: 'Preview';
		priority: 1;
		stencil: [ | container |
			container := BlElement new
					layout: BlLinearLayout horizontal;
					padding: (BlInsets all: 5);
					constraintsDo: [ :c | 
						c horizontal fitContent.
						c vertical fitContent ].
			self negative
				ifTrue: [
					container addChild: (self
							newLabel: '-'
							withLegend: nil
							primary: true) ].
			container addChild: (self
						newLabel: (self days printString)
						withLegend: 'days'
						primary: true).
			container addChild: (self
						newLabel: ':'
						withLegend: nil
						primary: false).
			container addChild: (self
						newLabel: (self hours abs printStringPadded: 2)
						withLegend: 'hours'
						primary: true).
			container addChild: (self
						newLabel: ':'
						withLegend: nil
						primary: false).
			container addChild: (self
						newLabel: (self minutes abs printStringPadded: 2)
						withLegend: 'minutes'
						primary: true).
			container addChild: (self
						newLabel: ':'
						withLegend: nil
						primary: false).
			container addChild: (self
						newLabel: (self seconds abs truncated printStringPadded: 2)
						withLegend: 'seconds'
						primary: true).
			container addChild: (self
						newLabel: '.'
						withLegend: nil
						primary: false).
			container addChild: (self
						newLabel: (self nanoSeconds abs)
						withLegend: 'nanoseconds'
						primary: true).
			container ]
]

{ #category : #'*GToolkit-Inspector' }
Duration >> gtViewDetailsIn: composite [
	<gtView>
	^ composite columnedList
		title: 'Details';
		items: [ {('human readable' -> self humanReadablePrintString).
			('days' -> self days).
			('hours' -> self hours).
			('minutes' -> self minutes).
			('seconds' -> self seconds).
			('nanoseconds' -> self nanoSeconds)} ];
		column: 'Key' text: #key;
		column: 'Value' text: #value;
		send: #value
]
