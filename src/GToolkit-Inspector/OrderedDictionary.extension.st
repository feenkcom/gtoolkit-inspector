Extension { #name : #OrderedDictionary }

{ #category : #'*GToolkit-Inspector' }
OrderedDictionary >> gtItemsFor: aView [
	^ aView explicit
		title: 'Items';
		stencil: [
			| list |
			list := BrColumnedList new display: self associations.
			list addEventHandler: GtInspectorListToSelectHandler new.
			list column 
				title: 'Key';
				stencil: [ :each | BrListLabelStencil matchParent: (GTObjectPrinter asTruncatedTextFrom: each key) ].
			list column 
				title: 'Value';
				stencil: [ :each | BrListLabelStencil matchParent: (GTObjectPrinter asTruncatedTextFrom: each value) ].
			list
			].
]
