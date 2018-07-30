*GToolkit-Inspector
gtAllReferencesOutsideFor: aView
	<gtView: 20>
	
	^ aView 
		title: 'All Ref Outside';
		stencil: [
			| list |
			list := BrColumnedList new display: [ ((SystemNavigation default allReferencesTo: self binding) 
							reject: [ :method | method package name == self package name ])
						sorted: [ :x :y | x name < y name ] ].
			list column 
				title: 'Method';
				stencil: [ :each | BrListLabelStencil matchParent: each name ].
			list column 
				title: 'Package';
				stencil: [ :each | BrListLabelStencil matchParent: each package name ].
			list
			].
		