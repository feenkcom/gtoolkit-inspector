*GToolkit-Inspector
gtActionsFromPragmas: aCollection 
	| aToolbar aToolbarItem |
	aToolbar := BrToolbar new.
	aToolbar look: BrToolbarLook horizontal.
	
	aCollection collect: [ :eachPragma | 
		aToolbarItem := BrToolbarItem new.
		aToolbarItem stencil: ([ thisContext
							object: self
							perform: eachPragma methodSelector
							withArguments: {}
							inClass: self class]
					on: Error
					do: [ :error |
						error freeze.
						GtPhlowViewWithError new 
							title: 'Error';
							error: error ]).
		aToolbarItem look: BrToolbarItemLook + BrMouseHoverLook + BrMouseClickLook.
		aToolbar addItem: aToolbarItem.
	 ].
	 ^ aToolbar