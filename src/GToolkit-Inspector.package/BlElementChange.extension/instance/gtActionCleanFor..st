*GToolkit-Inspector
gtActionCleanFor: anAction
	<gtAction>
	| action |
	action := anAction explicit.
	^ action stencil: [
		| button |
		button := BrButton new.
		button
		look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook; 
		action: [ records removeAll. action targetElement requestLayout  ];
		icon: GLMUIThemeExtraIcons glamorousTrash asElement;
		label: 'Clean log'.
	].