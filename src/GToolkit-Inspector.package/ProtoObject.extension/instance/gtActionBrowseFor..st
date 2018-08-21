*GToolkit-Inspector
gtActionBrowseFor: anAction
	<gtAction>
	| button |
	^ anAction explicit stencil: [
		button := BrButton new.
		button
			look: BrGlamorousButtonExteriorRectangularLook + 
					BrGlamorousButtonIconLook;
			icon: BrGlamorousIcons browse asElement;
			action: [ Smalltalk tools browser openOnClass: self class ] ]