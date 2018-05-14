*GToolkit-Inspector
gtViewsElementInContext: aGTInspector
	| tabs tabGroup |
	tabs := OrderedCollection new.
	(self gtViewsInContext: aGTInspector) do: [ :view |
		"we explicitly traverse the collection because it is possible for
		asElementDo: to not return anything when we deal with a NullView"
		view asElementDo: [ :element |
			tabs add: (BrTabModel new
				label: view title;
				content: [ element ] ) ] ].
	tabGroup := BrTabGroupModel with: tabs.
	tabGroup tabs do: [ :aTab |
		BlElement new
			look: BrMaterialTabLabelledLook;
			viewModel: aTab ].
	^ BlElement new
		constraintsDo: [ :c | 
			c vertical matchParent. 
			c horizontal matchParent ];
		look: BrMaterialTabGroupLook;
		viewModel: tabGroup
