*GToolkit-Inspector
gtSendersFor: aView
	<gtView>
	^ aView explicit
		title: 'Senders';
		priority: 10;
		stencil: [ 
			| list |
			list := BrColumnedList new display: self compiledMethod senders.
			list addEventHandler: GtInspectorListToSelectHandler new.
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