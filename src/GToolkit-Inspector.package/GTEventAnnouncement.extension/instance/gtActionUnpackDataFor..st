*GToolkit-Inspector
gtActionUnpackDataFor: anAction
	<gtAction>
	self data isNil ifTrue: [ ^ anAction noAction ].
	^ anAction explicit
		stencil: [
			| button |
			button := BrButton new.
			button
			look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
			action: [button fireEvent: (GtPhlowObjectToSpawn new
				object: self unpackedData;
				sourceElement: button)];
			icon: GLMUIThemeExtraIcons glamorousAdd asElement;
			label: 'Unpack data'
		]