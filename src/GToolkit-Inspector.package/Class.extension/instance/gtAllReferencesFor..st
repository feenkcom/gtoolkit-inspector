*GToolkit-Inspector
gtAllReferencesFor: aView
	<gtView>
	
	^ aView explicit 
		title: 'All Ref';
		priority: 19;
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
		