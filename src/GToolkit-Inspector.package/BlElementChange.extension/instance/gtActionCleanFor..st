*GToolkit-Inspector
gtActionCleanFor: anAction
	<gtAction>
	| action |
	action := anAction explicit.
	^ action stencil: [ :element |
		| button |
		button := BrButton new.
		button
		look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook; 
		action: [ records removeAll. element refresh ];
		icon: GLMUIThemeExtraIcons glamorousTrash asElement;
		label: 'Clean log'.
	].