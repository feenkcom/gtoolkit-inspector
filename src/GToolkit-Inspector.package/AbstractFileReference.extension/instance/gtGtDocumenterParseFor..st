*GToolkit-Inspector
gtGtDocumenterParseFor: anAction
	<gtAction>
	|  button |
	(self exists not or: [ (self extension = 'pillar') not]) ifTrue: [ ^ anAction noAction].
	^ anAction explicit stencil: [
		button := BrButton new.
		button
		look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
		action:  [
				button fireEvent: (GtPhlowObjectToSpawn new
				object: self parseWithGtDocumenter ;
				sourceElement: button) ];
		icon: GLMUIThemeExtraIcons glamorousRight asElement;
		label: 'Parse using GToolkit Documenter' translated.
	]