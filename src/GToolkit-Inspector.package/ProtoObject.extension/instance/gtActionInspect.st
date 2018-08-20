*GToolkit-Inspector
gtActionInspect
	<gtAction>
	| button |
	button := BrButton new.
	button
		look: BrGlamorousButtonExteriorCircularLook + BrGlamorousButtonIconLook;
		icon: GLMUIThemeExtraIcons glamorousInspect asElement;
		action: [ 
			button fireEvent: (GtPhlowObjectToSpawn new
				object: self;
				sourceElement: button) ].
	^ button