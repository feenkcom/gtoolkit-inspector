Extension { #name : #Magnitude }

{ #category : #'*GToolkit-Inspector' }
Magnitude >> formatNanoseconds: nanoseconds [
	| n len |
	nanoseconds = 0 ifTrue: [ ^ '0' ].
	n := nanoseconds.
	len := 9.
	[ n \\ 10 = 0 ]
		whileTrue: [ n := n / 10.
			len := len - 1 ].
	^ n printStringBase: 10 length: len padded: true
]

{ #category : #'*GToolkit-Inspector' }
Magnitude >> gtLiveFor: aView [

	^ self gtPreviewFor: aView
]

{ #category : #'*GToolkit-Inspector' }
Magnitude >> gtPreviewFor: aView [
	<gtView>
	^ aView explicit
		title: 'Preview';
		priority: 1;
		stencil: [ 
			| aNumberElement |
			aNumberElement := BrLabel new 
				text: self gtDisplayString;
				aptitude: (BrGlamorousLabelAptitude new fontSize: 20) + BrShadowAptitude;
				background: Color white;
				margin: (BlInsets all: 20);
				padding: (BlInsets all: 10);
				layout: BlLinearLayout horizontal;
				constraintsDo: [ :c | 
					c vertical fitContent.
					c horizontal fitContent.
					c frame horizontal alignCenter.
					c frame vertical alignCenter ].
			BlElement new 
				constraintsDo: [:c | 
					c vertical matchParent.
					c horizontal matchParent];
				layout: BlFrameLayout new;
				addChild: aNumberElement ]
]

{ #category : #'*GToolkit-Inspector' }
Magnitude >> newLabel: label withLegend: legend primary: primary [
	| container largeLabel smallLabel center |
	container := BlElement new
			layout: BlLinearLayout vertical;
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ].
	largeLabel := BrLabel new
			aptitude: (BrGlamorousLabelAptitude new
					perform: (primary ifTrue: #yourself ifFalse: #thin);
					foreground: (primary ifTrue: [ Color black ] ifFalse: [ Color gray ]);
					fontSize: 32);
			text: label.
	container addChild: largeLabel.
	legend
		ifNotNil: [ smallLabel := BrLabel new
					aptitude: (BrGlamorousLabelAptitude new thin
							foreground: Color gray;
							fontSize: 10);
					text: legend;
					constraintsDo: [ :c | 
						c horizontal fitContent.
						c vertical fitContent ].
			center := BlElement new
					constraintsDo: [ :c | 
						c horizontal matchParent.
						c vertical matchParent ];
					layout: BlLinearLayout new alignCenter.
			center addChild: smallLabel.
			container addChild: center ].
	^ container
]
