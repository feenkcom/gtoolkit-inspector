*GToolkit-Inspector
gtShortcutsFor: aView
	<gtView: 10>
	self shortcuts ifEmpty: [ ^ GtPhlowEmptyView new ].
	^ aView explicit 
		title: 'Shortcuts' translated;
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