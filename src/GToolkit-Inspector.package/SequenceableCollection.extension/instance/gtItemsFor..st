*GToolkit-Inspector
gtItemsFor: aView
	^ aView explicit
		title: 'Items';
		stencil: [ 
			| list |
			list := BrColumnedList new display: self.
			list addEventHandler: GtInspectorListToSelectHandler new.
			list column
				title: 'Index';
				stencil: [ :aClass :anIndex |
					BlTextElement new
						width: 30;
						margin: (BlInsets all: 3);
						text: (anIndex asString asRopedText foreground: Color gray) ].
			list column
				title: 'Item';
				stencil: [ :each :index | BrListLabelStencil new text: each gtDisplayString ].
			list ]