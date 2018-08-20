*GToolkit-Inspector
gtOpenInSpaceFor: anAction
	<gtAction>
	self hasParent ifTrue: [ ^ anAction noAction].
	^ anAction explicit stencil: [
		| button |
		button := BrButton new.
		button
		look: BrGlamorousButtonExteriorCircularLook + BrGlamorousButtonIconLook; 
		action:  [ self hasParent ifFalse: [ BlSpace new rootDo:[:r| r addChild: self];show ]];
		icon: GLMUIThemeExtraIcons glamorousPlay asElement;
		label: 'Open in Space' translated.
	].