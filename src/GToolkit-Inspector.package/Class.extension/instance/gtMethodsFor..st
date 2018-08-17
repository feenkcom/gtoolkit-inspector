*GToolkit-Inspector
gtMethodsFor: aView
	<gtView: 21>
	^ aView explicit 
		title: 'Methods' translated;
		stencil: [
			| list |
			list := BrColumnedList new display: [ 
				(self methods collect: #asRingDefinition) 
					sorted: [ :x :y | x selector < y selector ] ].
			list addEventHandler: GtInspectorListToSelectHandler new.
			list column 
				title: 'Selector' translated;
				stencil: [ :each :rowIndex | (BrListLabelStencil matchParent: each selector) asElement
					when: BlClickEvent do: [ :anEvent |
						anEvent consumed: true.
						list selectOne: rowIndex ] ].
			list column 
				title: 'Class' translated;
				stencil: [ :each :rowIndex  | (BrListLabelStencil fitContent: each methodClass name) asElement ].
			list ]