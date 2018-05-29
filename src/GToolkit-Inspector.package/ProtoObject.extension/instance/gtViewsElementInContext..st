*GToolkit-Inspector
gtViewsElementInContext: aGTInspector
	| tabs |
	
	tabs := OrderedCollection new.
	(self gtViewsInContext: aGTInspector) do: [ :view |
		"we explicitly traverse the collection because it is possible for
		asElementDo: to not return anything when we deal with an EmptylView"
		view asElementDo: [ :element |
			tabs add: (BrTab new
				look: BrMaterialTabLabelledLook;
				label: view title;
				stencil: [ element asScrollableElement ]) ] ].

	^ BrTabGroup new
		look: BrMaterialTabGroupLook;
		addTabs: tabs;
		constraintsDo: [ :c | 
			c vertical matchParent. 
			c horizontal matchParent ]