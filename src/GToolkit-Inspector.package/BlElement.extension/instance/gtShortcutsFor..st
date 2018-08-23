*GToolkit-Inspector
gtShortcutsFor: aView
	<gtView>
	self shortcuts ifEmpty: [ ^ GtPhlowEmptyView new ].
	^ aView explicit 
		title: 'Shortcuts' translated;
		priority: 10;
		stencil: [
			| list |
			list := BrColumnedList new display: self shortcuts.
			list column 
				title: 'Key';
				stencil: [ :each | BrListLabelStencil matchParent: each combination gtDisplayString ].
			list column 
				title: 'Action';
				stencil: [ :each | BrListLabelStencil matchParent: each action asString ].
			list
			].