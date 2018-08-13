*GToolkit-Inspector
gtSubjectsFor: aView
	<gtView: 4>
	self hasSubjects ifFalse: [ ^ aView empty ].
	"^ ((self subjects gtItemsFor: aView)
		actionStencil: [ BrButton new 
			look: BrMaterialToggleLabelledLook;
			icon: (Smalltalk ui icons iconNamed: #glamorousBookmark);
			action: [ GtExampleNavigation browseAllExampleSubjects: { self } ] 
		])
		title: 'Subjects'"
	^ (self subjects gtItemsFor: aView)
		title: 'Subjects'
		