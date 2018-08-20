*GToolkit-Inspector
gtActionCleanFor: anAction
	<gtAction>
	^ anAction explicit stencil: [
		| button |
		button := BrButton new.
		button
		look: BrGlamorousButtonExteriorCircularLook + BrGlamorousButtonIconLook; 
		action:  [  records removeAll. ];
		icon: GLMUIThemeExtraIcons glamorousTrash asElement;
		label: 'Clean log'.
	].