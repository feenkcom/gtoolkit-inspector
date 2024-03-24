Extension { #name : #Date }

{ #category : #'*GToolkit-Inspector' }
Date >> gtDetailsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Details';
		items: [ {('iso' -> self yyyymmdd).
			('year' -> self year).
			('month' -> self monthIndex).
			('month name' -> self monthName).
			('day of month' -> self dayOfMonth).
			('day of week' -> self dayOfWeekName).
			('day of year' -> self dayOfYear)} ];
		column: 'Key' text: #key;
		column: 'Value' text: #value;
		send: #value
]

{ #category : #'*GToolkit-Inspector' }
Date >> gtPreviewFor: aView [
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
			container addChild: (self
						newLabel: (self year printStringPadded: 4)
						withLegend: 'year'
						primary: true).
			container addChild: (self
						newLabel: '-'
						withLegend: nil
						primary: false).
			container addChild: (self
						newLabel: (self monthIndex printStringPadded: 2)
						withLegend: 'month'
						primary: true).
			container addChild: (self
						newLabel: '-'
						withLegend: nil
						primary: false).
			container addChild: (self
						newLabel: (self dayOfMonth printStringPadded: 2)
						withLegend: 'day'
						primary: true).
			container ]
]
