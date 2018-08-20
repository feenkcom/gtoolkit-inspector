*GToolkit-Inspector
gtZipItemsFor: aView
	<gtView>
	(self isFile and: [ #('zip' 'jar' 'ear' 'war' 'mcz') includes: self extension ]) ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Picture';
		priority: 10;
		stencil: [ 
			| list children root |
			root := (FileSystem zip: self) open workingDirectory.
			children := root directories, root files.
			children := self isRoot 
				ifTrue: [ children ]
				ifFalse: [ children asOrderedCollection addFirst: self parent; yourself ].
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
			list 
			
			
			
			 ]
		
"	^ composite table 
		title: 'Items';
		display: [ 
			| children root |
			root := (FileSystem zip: self) open workingDirectory.
			children := root directories, root files.
			self isRoot 
				ifTrue: [ children ]
				ifFalse: [ 
					children asOrderedCollection 
						addFirst: self parent;
						yourself ] ];
		column: 'Name' evaluated: [:each | self parent = each 
								ifTrue: [ '..' ] 
								ifFalse: [ each basename ]] width: 400;
		column: 'Size' evaluated: [:each | each humanReadableSize] width: 100;
		column: 'Creation' evaluated: [ :each | 
			String streamContents: [:s | 
				each creationTime printYMDOn: s.
				s nextPut: Character space.
				each creationTime printHMSOn: s ]];
		icon: [ :each | 
			each isDirectory 
				ifTrue: [ GLMUIThemeExtraIcons glamorousFolder ] 
				ifFalse: [ GLMUIThemeExtraIcons glamorousBrowse ] ];
		act: [ :table | table update ] icon: GLMUIThemeExtraIcons glamorousRefresh entitled: 'Refresh'"