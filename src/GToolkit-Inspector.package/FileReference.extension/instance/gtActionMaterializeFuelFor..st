*GToolkit-Inspector
gtActionMaterializeFuelFor: anAction
	<gtAction>
	|  button |
	(self exists not or: [ (self extension = 'fuel') not]) ifTrue: [ ^ anAction noAction].
	^ anAction explicit stencil: [
		button := BrButton new.
		button
		look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
		action:  [
				button fireEvent: (GtPhlowObjectToSpawn new
				object: (FLMaterializer materializeFromFileNamed: self fullName);
				sourceElement: button) ];
		icon: GLMUIThemeExtraIcons glamorousAdd asElement;
		label: 'Parse using GToolkit Documenter' translated.
	]