*GToolkit-Inspector
gtActionsFromPragmas: aCollection 
	| aToolbar aToolbarItem theContext |
	
	aToolbar := BrToolbar new.
	aToolbar look: BrToolbarLook horizontal.
	
	theContext := thisContext.
	aCollection do: [ :eachPragma | 
		aToolbar addItem: (
			[ theContext
				object: self
				perform: eachPragma methodSelector
				withArguments: {}
				inClass: self class ]
			on: Error
			do: [ :error |
				error freeze.
				GtPhlowViewWithError new 
					title: 'Error';
					error: error ]) ].
	 ^ aToolbar