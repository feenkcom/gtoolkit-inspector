Extension { #name : #FileReference }

{ #category : #'*GToolkit-Inspector' }
FileReference >> gtActionMaterializeFuelFor: anAction [
	<gtAction>
	|  button |
	(self exists not or: [ (self extension = 'fuel') not]) ifTrue: [ ^ anAction noAction].
	^ anAction explicit stencil: [
		button := BrButton new.
		button
		look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
		action:  [
				button fireEvent: (GtPhlowObjectToSpawn new
				object: (FLMaterializer materializeFromFileNamed: self fullName);
				sourceElement: button) ];
		icon: BrGlamorousIcons play asElement;
		label: 'Parse using GToolkit Documenter' translated.
	]
]

{ #category : #'*GToolkit-Inspector' }
FileReference >> gtContentsFor: aView [
	<gtView>
	self isFile ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Contents';
		priority: 50;
		stencil: [ 
			| contents |
			contents := self readStreamDo: [ :stream | 
				| result |
				result := [stream contents ]
					on: Error 
					do: [ (stream binary next: 10000) asString ] ].
			BrEditorElement new 
				editor: (BrTextEditor new text: contents asRopedText);
				constraintsDo: [ :c |
				    c horizontal matchParent.
				    c vertical matchParent ] ];
		actionStencil: [ :tab | 
			BrButton new 
				look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
				icon: BrGlamorousIcons accept asElement;
				action: [ 
					| newContents | 
					newContents := tab viewContentElement editor text asString.
					(self fullName, '.backup') asFileReference ensureDelete.
					self copyTo: (self fullName, '.backup') asFileReference.
					self ensureDelete; writeStreamDo: [ :s | s nextPutAll: newContents ] ] ]
]

{ #category : #'*GToolkit-Inspector' }
FileReference >> gtGifFor: aView [
	<gtView>
	(self isFile and: [ self mimeTypes notNil and: [ self mimeTypes first matches: ZnMimeType imageGif ] ]) ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Picture';
		priority: 10;
		stencil: [ 
			(self binaryReadStreamDo: [ :stream | GIFReadWriter formFromStream: stream ]) asElement asPannableElement ]
]

{ #category : #'*GToolkit-Inspector' }
FileReference >> gtItemsFor: aView [
	<gtView>
	self isDirectory ifFalse: [ ^ aView empty ].
	^ aView explicit 
		title: 'Items';
		priority: 10; 
		stencil: [
			| list children |
			children := self directories, self files.
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
						ifTrue: [ BrGlamorousIcons folder ] 
						ifFalse: [ BrGlamorousIcons file ]) ].

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
]

{ #category : #'*GToolkit-Inspector' }
FileReference >> gtJpgFor: aView [
	<gtView>
	(self isFile and: [ self mimeTypes notNil and: [ self mimeTypes first matches: ZnMimeType imageJpeg ] ]) ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Picture';
		priority: 10;
		stencil: [ 
			(self binaryReadStreamDo: [ :stream | JPEGReadWriter formFromStream: stream ]) asElement asPannableElement ]
]

{ #category : #'*GToolkit-Inspector' }
FileReference >> gtPharoScriptFor: aView [
	<gtView>
	(self isFile and: [ self extension = 'st' or: [self extension = 'ph'] ]) ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Script';
		priority: 10;
		stencil: [ 
			GtPharoSnippet new 
				sourceCode: (self readStreamDo: [ :s | s contents ]);
				asElement ]
		"act: [ :text |
			self ensureDelete; writeStreamDo: [ :s | s nextPutAll: text text asString ] ]
			icon: GLMUIThemeExtraIcons glamorousSave
			on: $s
			entitled: 'Save'"
]

{ #category : #'*GToolkit-Inspector' }
FileReference >> gtPngFor: aView [
	<gtView>
	(self isFile and: [ self mimeTypes notNil and: [ self mimeTypes first matches: ZnMimeType imagePng ] ]) ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Picture';
		priority: 10;
		stencil: [ 
			(self binaryReadStreamDo: [ :stream | PNGReadWriter formFromStream: stream ]) asElement asPannableElement ]
]

{ #category : #'*GToolkit-Inspector' }
FileReference >> gtZipItemsFor: aView [
	<gtView>
	(self isFile and: [ #('zip' 'jar' 'ear' 'war' 'mcz') includes: self extension ]) ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Archive';
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
]
