*GToolkit-Inspector
gtAllReferencesFor: aView
	<gtView: 10>
	
	^ aView 
		title: 'All Ref';
		stencil: [
			| list |
			list := BrColumnedList new display: [ (SystemNavigation default allReferencesTo: self binding) 
						sorted: [ :x :y | x name < y name ] ].
			list column 
				title: 'Method';
				stencil: [ :each | BrListLabelStencil matchParent: each name ].
			list column 
				title: 'Package';
				stencil: [ :each | BrListLabelStencil matchParent: each package name ].
			list
			].
		