*GToolkit-Inspector
gtMethodsFor: aView
	<gtView: 10>
	^ aView 
		title: 'Methods' translated;
		stencil: [
			| list |
			list := BrColumnedList new display: [ (self methods collect: #asRingDefinition) 
						sorted: [ :x :y | x selector < y selector ] ].
			list column 
				title: 'Selector';
				stencil: [ :each | BrListLabelStencil matchParent: each selector ].
			list column 
				title: 'Class';
				stencil: [ :each | BrListLabelStencil fitContent: each methodClass name ].
			list
			].