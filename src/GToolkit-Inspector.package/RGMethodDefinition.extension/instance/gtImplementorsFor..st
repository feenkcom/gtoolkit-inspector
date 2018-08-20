*GToolkit-Inspector
gtImplementorsFor: aView
	<gtView>
	^ aView explicit
		title: 'Implementors';
		priority: 11;
		stencil: [ 
			| list |
			list := BrColumnedList new display: self compiledMethod implementors.
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