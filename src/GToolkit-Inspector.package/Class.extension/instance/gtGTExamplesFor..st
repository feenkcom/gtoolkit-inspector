*GToolkit-Inspector
gtGTExamplesFor: aView
	<gtView: 10>
	^ aView 
		title: 'Examples';
		stencil: [
			| list |
			list := BrColumnedList new display: self gtExamples.	
			
			list column
				title: 'Name';
				stencil: [ :each | 
					| textElement text |
					text := each gtDisplayString .
					textElement :=  (BrListLabelStencil matchParent: text) asElement.
					textElement constraintsDo: [ :c | c horizontal matchParent. c padding: (BlInsets left: 10) ].
					 ].
			list
			]