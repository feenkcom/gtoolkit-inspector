*GToolkit-Inspector
gtViewsElementInContext: aGTInspector
	| tabs tabGroup |
	tabs := (self gtViewsInContext: aGTInspector) collect: [ :view |
		view asElementDo: [ :element |
			BrTabModel new
				label: view title;
				content: [ element ] ] ].
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
