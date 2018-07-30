*GToolkit-Inspector
gtInstanceVariablesFor: aView
	<gtView: 10>
	^ aView 
		title: 'InstVars';
		stencil: [
			| list |
			list := BrColumnedList new display: [ self class allInstVarNames sorted collect: [ :each | each -> (self instVarNamed: each) ] ].
			list column
				title: 'Variable';
				stencil: [ :each | 
					| label |
					label := BrListLabelStencil fitContent: each key.
					label constraintsDo: [ :c | c horizontal exact:200 ] ].
			list column
				title: 'Value';
				stencil: [ :each | BrListLabelStencil matchParent: each value ].
			list ]