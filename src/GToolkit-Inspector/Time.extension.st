Extension { #name : #Time }

{ #category : #'*GToolkit-Inspector' }
Time >> gtDetailsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Details';
		items: [ {('iso' -> self print24).
			('hours' -> self hours).
			('minutes' -> self minutes).
			('seconds' -> self seconds).
			('nanoseconds' -> self nanoSecond).
			('meridian' -> self meridianAbbreviation)} ];
		column: 'Key' text: #key;
		column: 'Value' text: #value;
		send: #value
]

{ #category : #'*GToolkit-Inspector' }
Time >> gtPreviewFor: aView [
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
						newLabel: (self hours printStringPadded: 2)
						withLegend: 'hours'
						primary: true).
			container addChild: (self
						newLabel: ':'
						withLegend: nil
						primary: false).
			container addChild: (self
						newLabel: (self minutes printStringPadded: 2)
						withLegend: 'minutes'
						primary: true).
			container addChild: (self
						newLabel: ':'
						withLegend: nil
						primary: false).
			container addChild: (self
						newLabel: (self seconds printStringPadded: 2)
						withLegend: 'seconds'
						primary: true).
			container addChild: (self
						newLabel: '.'
						withLegend: nil
						primary: false).
			container addChild: (self
						newLabel: (self formatNanoseconds: self nanoSecond)
						withLegend: 'nanoseconds'
						primary: false).
			container ]
]

{ #category : #'*GToolkit-Inspector' }
Time >> hhmmss24 [
 	"Return a string of the form 112345 (for 11:23:45 am), 215432 (for 9:54:32 pm), of exactly 6 digits"

 	^ String new: 6 streamContents: [ :aStream |
		self hour printOn: aStream base: 10 length: 2 padded: true.
		self minute printOn: aStream base: 10 length: 2 padded: true.
		self second printOn: aStream base: 10 length: 2 padded: true ]
]
