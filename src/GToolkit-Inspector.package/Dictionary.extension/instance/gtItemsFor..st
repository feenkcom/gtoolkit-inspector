*GToolkit-Inspector
gtItemsFor: aView
	^ aView
		title: 'Items';
		stencil: [
			| list |
			list := BrColumnedList new display: self associations.
			list column 
				title: 'Key';
				stencil: [ :each | BrListLabelStencil matchParent: (GTObjectPrinter asTruncatedTextFrom: each key) ].
			list column 
				title: 'Value';
				stencil: [ :each | BrListLabelStencil matchParent: (GTObjectPrinter asTruncatedTextFrom: each value) ].
			list
			].