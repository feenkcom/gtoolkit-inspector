*GToolkit-Inspector
gtSendersFor: aView
	<gtView: 4>
	^ aView
		title: 'Senders';
		stencil: [ 
			| list |
			list := BrColumnedList new display: self compiledMethod senders.
			list column
				title: 'Index';
				stencil: [ :aClass :anIndex |
					BlTextElement new
						width: 30;
						margin: (BlInsets all: 3);
						text: (anIndex asString asRopedText foreground: Color gray) ].
			list column
				title: 'Method';
				stencil: [ :each :index | BrListLabelStencil new text: each gtDisplayString ].
			list ]