*GToolkit-Inspector
gtGtDocumenterParse
	<gtAction>
	| button |
	button  := BrButton new.
	button
	look: BrMaterialToggleIconifiedLook;
	action:  [
				button fireEvent: (GtPhlowObjectToSpawn new
				object: self parseWithGtDocumenter ;
				sourceElement: button) ];
	"condition: [ self exists and: [ self extension = 'pillar' ] ];"
	icon: GLMUIThemeExtraIcons glamorousRight asElement;
	label: 'Parse using GToolkit Documenter' translated.
	^ button	
