*GToolkit-Inspector
gtOpenInSpaceFor: anAction
	<gtAction>
	self hasParent ifTrue: [ ^ anAction noAction].
	^ anAction explicit stencil: [
		| button |
		button := BrButton new.
		button
		look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook; 
		action:  [ self hasParent ifFalse: [ BlSpace new rootDo:[:r| r addChild: self];show ]];
		icon: BrGlamorousIcons play asElement;
		label: 'Open in Space' translated.
	].