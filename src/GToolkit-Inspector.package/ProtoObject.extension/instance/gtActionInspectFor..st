*GToolkit-Inspector
gtActionInspectFor: anAction
	<gtAction>
	| button |
	anAction explicit
	stencil: [
	button := BrButton new.
	button
		look: BrMaterialToggleIconifiedLook;
		icon: GLMUIThemeExtraIcons glamorousInspect asElement;
		action: [ 
			button fireEvent: (GtPhlowObjectToSpawn new
				object: self;
				sourceElement: button) ].
			].
	^ anAction