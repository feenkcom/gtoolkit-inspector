*GToolkit-Inspector
gtItemsFor: aView
	<gtView: 0>
	self isDirectory ifFalse: [ ^ aView empty ].
	^ aView explicit 
		title: 'Items';
		stencil: [
			| list children |
			children := self directories, self files.
			children := self isRoot 
				ifTrue: [ children ]
				ifFalse: [ 
					children asOrderedCollection 
						addFirst: self parent;
						yourself ].

			list := BrColumnedList new display: children.
			list addEventHandler: GtInspectorListToSelectHandler new.
			list constraintsDo: [ :c | c padding: (BlInsets top: 10) ].
			
			list column
				title: 'Icon';
				stencil: [ :each :index |
					BrImageStencil new image: (each isDirectory 
						ifTrue: [ GLMUIThemeExtraIcons glamorousFolder ] 
						ifFalse: [ GLMUIThemeExtraIcons glamorousBrowse ]) ].

			list column
				title: 'Name';
				stencil: [ :each :index | 
					| textElement text |
					text := (self isChildOf: each) 
						ifTrue: [ '..' ]
						ifFalse: [ each basename asString ].

					textElement :=  (BrListLabelStencil matchParent: text) asElement.
					textElement constraintsDo: [ :c | c horizontal matchParent. c padding: (BlInsets left: 10) ] ].
			list column
				title: 'Size';
				stencil: [:each |  
					| textElement |
					textElement := (BrListLabelStencil fitContent: each humanReadableSize asString) asElement.
					textElement constraintsDo: [ :c | c padding: (BlInsets right: 10)].].
				
			list column
				title: 'Creation';
				stencil: [ :each | 
					| textElement |
					textElement := (BrListLabelStencil fitContent: (String streamContents: [:s | 
					each creationTime printYMDOn: s.
					s nextPut: Character space.
					each creationTime printHMSOn: s ]) ) asElement.
				 textElement constraintsDo: [ :c |  c padding: (BlInsets left: 10; right: 10) ] ].
			list ]