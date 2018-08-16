*GToolkit-Inspector
gtItemsFor: aView
	<gtView: 0>
	self isDirectory ifFalse: [ ^ aView empty ].
	^ aView 
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
			
			list column
				title: 'Icon';
				stencil: [ :each :index |
				| icon |
					each isDirectory 
				ifTrue: [ icon := BrImageStencil new image: GLMUIThemeExtraIcons glamorousFolder ] 
				ifFalse: [ icon := BrImageStencil new image: GLMUIThemeExtraIcons glamorousBrowse ].
				icon asElement constraintsDo: [ :c | c horizontal exact:15. c vertical exact:20. c padding: (BlInsets top: 2) ];
				when: BlClickEvent do: [ :anEvent  |
						anEvent consumed: true.
						list selectOne: index. ].
					].
			
			list column
				title: 'Name';
				stencil: [ :each :index | 
					| textElement text |
					text := (self isChildOf: each) 
								ifTrue: [ '..' ] ifFalse: [ each basename asString ].
								
					textElement :=  (BrListLabelStencil matchParent: text) asElement.
					textElement constraintsDo: [ :c | c horizontal matchParent. c padding: (BlInsets left: 10) ].
					textElement when: BlClickEvent do: [ :anEvent  |
						list selectOne: index.
						anEvent consumed: true. ]
					 ].
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
				 textElement constraintsDo: [ :c |  c padding: (BlInsets left: 10; right: 10)]].
			
			list constraintsDo: [ :c | c padding: (BlInsets top: 10)  ].
			
			list addEventHandler: GtInspectorListToSpawnHandler new ]