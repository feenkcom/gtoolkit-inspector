*GToolkit-Inspector
gtActionInspectFor: anAction
	<gtAction>
	| button |
	^ anAction explicit stencil: [
		button := BrButton new.
		button
			look: BrGlamorousButtonExteriorRectangularLook + 
					BrGlamorousButtonIconLook;
			icon: BrGlamorousIcons inspect asElement;
			action: [ 
				button fireEvent: (GtPhlowObjectToSpawn new
					object: self;
					sourceElement: button) ] ]