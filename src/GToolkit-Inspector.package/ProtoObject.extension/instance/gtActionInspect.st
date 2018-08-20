*GToolkit-Inspector
gtActionInspect
	<gtAction>
	^ BrButton new 
		look: BrMaterialToggleIconifiedLook;
		icon: GLMUIThemeExtraIcons glamorousInspect asElement;
		action: [ self inspect ]