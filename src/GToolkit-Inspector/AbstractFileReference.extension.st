Extension { #name : #AbstractFileReference }

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtActionMaterializeFuelFor: anAction [
	<gtAction>
	|  button |
	(self exists not or: [ (self extension = 'fuel') not]) ifTrue: [ ^ anAction noAction].
	^ anAction explicit stencil: [
		button := BrButton new.
		button
		aptitude: BrGlamorousButtonWithIconAptitude;
		action:  [
			button phlow spawnObject: (FLMaterializer materializeFromFileNamed: self fullName) ];
		icon: BrGlamorousVectorIcons play;
		label: 'Parse using GToolkit Documenter' translated.
	]
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtActionMaterializeXdFileFor: anAction [
	<gtAction>
	|  button |
	(self exists not or: [ (self extension = 'xdoc') not]) ifTrue: [ ^ anAction noAction].
	^ anAction explicit stencil: [
		button := BrButton new.
		button
		aptitude: BrGlamorousButtonWithIconAptitude;
		action:  [
			| reader xdFile |
			reader := XdReader new.
			xdFile := reader
				streamingStrategy: (XdStreamingStrategy file: self);
				read.
			button phlow spawnObject: xdFile ];
		icon: BrGlamorousVectorIcons play;
		label: 'Materialize xdoc file' translated.
	]
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtActionWebBrowseFor: anAction [
	<gtAction>
	(self exists or: [ self path isNetworkPath not ]) ifFalse: [ ^ anAction noAction ].

	^ anAction button
		  icon: BrGlamorousVectorIcons link;
		  tooltip: 'Open in operating system';
		  action: [ WebBrowser openOn: self fullName ]
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtChildren [
	self isDirectory ifFalse: [ ^ Array empty ].

	^ (self directories sorted: [:a :b | a basename < b basename ]) , 
		(self files sorted: [:a :b | a basename < b basename ]).
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtChildrenWithParent [
	| aChildrenCollection |
	self isDirectory ifFalse: [ ^ Array empty ].
	
	aChildrenCollection := self gtChildren.
	aChildrenCollection := self isRoot
		ifTrue: [ aChildrenCollection ]
		ifFalse: [ aChildrenCollection asOrderedCollection
			addFirst: self parent;
			yourself ].
	^ aChildrenCollection
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtContentsFor: aView [
	<gtView>
	| eventLoop |
	self isFile ifFalse: [ ^ aView empty ].
	[ self readStreamDo: [ :s | s next: 1000 ] ]
		on: ZnInvalidUTF8
		do: [ ^ aView empty ].

	"eventLoop := self watcher startLoop."

	^ aView explicit
		title: 'Contents' translated;
		priority: 50;
		"updateWhen: GtFileWatcherModificationAnnouncement in: eventLoop announcer;"
		stencil: [ self gtEditorView ]
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtDefaultInspectorTool [
	^ (self exists and: [ self isDirectory and: [ self path isNetworkPath not ] ])
		ifTrue: [ GtPhlowCompositeTool new
				addTool: super gtDefaultInspectorTool;
				addTool: (GtFileBrowserFolderTool forFolder: self) ]
		ifFalse: [ super gtDefaultInspectorTool ]
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtDetails [
	| details |
	details := {
		{ #self . self }.
		{ #printString. self printString }.
		{ #gtDisplayString. self gtDisplayString }.
		{ #pathString . self pathString }.
		{ #URL . 
			(self isAbsolute and: [ self path isAbsolute ]) 
				ifTrue: [ self asUrl ] 
				ifFalse: [ '' ] }.
		{ #base . self base }.
		{ #basename . self basename }.
		{ #extension . self extension }.
		{ #parent . self parent }.
		{ #path . self path }.
		{ #fullPath . self fullPath }.
		{ #absolutePath . self absolutePath }. 
		{ #fileSystem . self fileSystem }.
		{ #exists . self exists }.
		{ #isFile . self isFile }.
		{ #isDirectory . self isDirectory }.
		{ #isAbsolute . self isAbsolute }.
		{ #isRelative . self isRelative }.
	}.
	self exists ifTrue: [
		details := details , {
			{ #isReadable . self isReadable }.
			{ #isWritable . self isWritable }.
			{ #size . self humanReadableSize . self size }.
			{ #uid . self uid }.
			{ #gid . self gid }.
			{ #inode . self inode }.
			{ #creationTime . self creationTime }.
			{ #modificationTime . self modificationTime }.
			{ #changeTime . self changeTime }.
			{ #accessTime . self accessTime }.
			{ #permissions . self permissions }.
	} ].
	^ details
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtDetailsFor: composite [
	<gtView>
	^ composite columnedList
		title: 'Details';
		priority: 60;
		items: [ self gtDetails ];
		column: 'key' text: #first;
		column: 'value' text: #second weight: 3;
		send: #last
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtEditorView [
	| pane editor editorPane changeBlock originalText toolbar saveBlock |
	originalText := BlRunRopedText file: self.
	pane := BrVerticalPane new matchParent.
	editorPane := BrHorizontalPane new matchParent.
	editorPane padding: (BlInsets all: 5).
	editor := BrEditor new matchParent.
	changeBlock := [ editorPane
			childNamed: #modificationBar
			ifFound: [ :elmt | 
				elmt
					inUIProcessDo: [ elmt
							background: ((editor editor text equalsIgnoringAttributes: originalText)
									ifTrue: [ Color transparent ]
									ifFalse: [ elmt theme status changesBackgroundColor ]) ] ] ].
	saveBlock := [ self gtSaveContents: editor text asString.
		originalText := BlRunRopedText file: self.
		changeBlock value ].
	editor editor
		when: BrTextEditorInsertedEvent do: changeBlock;
		when: BrTextEditorDeletedEvent do: changeBlock;
		when: BlInfiniteDataSourceChanged do: changeBlock.
	editor
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination primaryS;
				action: saveBlock).
	editor editor text: (BlRunRopedText file: self).
	editor aptitude: BrGlamorousCodeEditorAptitude.
	editorPane
		addChild: (BlElement new
					width: 5;
					constraintsDo: [ :c | c vertical matchParent ];
					yourself)
			as: #modificationBar;
		addChild: editor as: #editor.
	toolbar := BrToolbar new
			aptitude: (BrGlamorousToolbarAptitude new spacing: 5);
			fitContent;
			margin: (BlInsets bottom: 5).
	toolbar
		addChild: (BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				beSmallSize;
				icon: BrGlamorousVectorIcons accept;
				label: 'Save';
				action: saveBlock)
		as: #saveButton.
	toolbar
		addChild: (BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				beSmallSize;
				icon: BrGlamorousVectorIcons cancel;
				label: 'Cancel';
				action: [ editor editor text: (BlRunRopedText file: self).
					changeBlock value ])
		as: #cancelButton.
	pane addChild: editorPane.
	pane addChild: toolbar as: #toolbar.
	pane addAptitude: (BrGlamorousWithVerticalScrollbarAptitude new scrollableName: #editor).
	^ pane
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtFigureFor: aView [
	<gtView>
	(self isFile and: [ 
		(ImageReadWriter allTypicalFileExtensions includes: self extension asLowercase) ]) ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Picture';
		priority: 10;
		stencil: [ (GtFileUtility imageElementFromFileReference: self)
			margin: (BlInsets all: 10) ]
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtHexContentsFor: aView [
	<gtView>
	self isFile
		ifFalse: [ ^ aView empty ].
	
	^ aView textEditor
		title: 'Hex' translated;
		priority: 90;
		text: [ 
			| displayString  |
			displayString := ''.
			(self binaryReadStreamDo: [ :stream | 
				| displayStream maxBytes buffer |
				maxBytes := 10000.
				buffer := stream next: maxBytes.
				displayStream := (String new: maxBytes * 5) writeStream.
				buffer hexDumpOn: displayStream max: maxBytes.
				displayString := displayStream contents asText ]) ];
		glamorousMonospace
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtHtmlFor: aView [
	<gtView>
	(self isFile and: [ self extension = 'html' ]) ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'HTML';
		priority: 10;
		stencil: [ GtProtoWebViewElement new
				url: 'file://' , self fullName;
				margin: (BlInsets all: 20);
				aptitude: BrShadowAptitude ]
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtItemsFor: aView [
	<gtView>
	| eventLoop |
	(self isDirectory not or: 
		[ self path isNetworkPath and: [ self path isRoot ] ])
			ifTrue: [ ^ aView empty ].

	"eventLoop := self watcher startLoop."

	^ aView columnedList
		title: 'Items' translated;
		priority: 10;
		"updateWhen: GtFileWatcherChangeAnnouncement in: eventLoop announcer;"
		items: [ self gtChildrenWithParent ];
		column: 'Icon' translated 
			icon: [ :each | 
				each isDirectory
					ifTrue: [ BrGlamorousVectorIcons folder ]
					ifFalse: [ BrGlamorousVectorIcons file ] ];
		column: 'Name' translated text: [ :each | 
			(self isChildOf: each)
				ifTrue: [ '..' ]
				ifFalse: [ each basename asString ] ];
		column: 'Size' translated
			text: [ :each | 
				[ each isDirectory 
					ifTrue: [ '--' ]
					ifFalse: [ each humanReadableSize asString ] ]
				on: FileException, FileSystemError
				do: [ :anException | anException return: '' ] ]
			width: 100;
		column: 'Creation' translated
			text: [ :each | 
				[ String
					streamContents: [ :s | 
						each creationTime printYMDOn: s.
						s nextPut: Character space.
						each creationTime printHMSOn: s ] ]
				on: FileException, FileSystemError
				do: [ :anException | anException return: '' ] ]
			width: 150;
		actionUpdateButton
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtJsonFor: aView [
	<gtView>
	(self isFile and: [ (GtFileUtility mimeTypeOfExtension: self extension) 
		= ZnMimeType applicationJson ]) ifFalse: [ ^ aView empty ].
	^ aView textEditor
		title: 'JSON';
		priority: 1;
		actionButtonIcon: BrGlamorousVectorIcons tree 
			tooltip: 'Inspect parsed JSON'
			action: [ :aButton | 
				aButton phlow spawnObject: (
					STONJSON fromString: self contents) ];
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		styler: [ JSONParser gtStyler ];
		text: [ (STONJSON toStringPretty: (
			STONJSON fromString: self contents)) ]
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtMovieViewFor: aView [
	<gtView>
	(self extension = 'mp4') ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Movie';
		stencil: [ GtProtoWebViewVideoFileElement new file: self ]
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtPathFor: aView [
	<gtView>
	<gtContextView: #FileSystemError>
	
	| aCount |
	
	aCount := 0.
	^ aView columnedList
		title: 'Path';
		priority: 55;
		items: [ | aCollection |
			aCollection := self asFileReference asAbsolute withParents.
			aCount := aCollection size.
			aCollection ];
		column: 'Icon'
			icon: [ :aFileReference | 
				aFileReference exists
					ifTrue: [ (GtInspectorAcceptIconStencil new
							radius: 8;
							thickness: 2) asElement
							background: BrGlamorousColors successBackgroundColor ]
					ifFalse: [ (BrPlusIconStencil close
							radius: 8;
							thickness: 2) asElement
							background: BrGlamorousColors errorBackgroundColor ] ]
			width: 35;
		column: 'Name'
			text: [ :aFileReference | 
				aFileReference basename
					, (aFileReference isDirectory ifTrue: [ '/' ] ifFalse: [ '' ]) ];
		column: 'Actions'
			stencil: [ :aFileReference :anIndex | 
				aFileReference exists
					ifTrue: [ BlElement new size: 0 @ 0 ]
					ifFalse: [ aFileReference parent exists
							ifFalse: [ BlElement new size: 0 @ 0 ]
							ifTrue: [ BrHorizontalPane new
									fitContent;
									in: [ :aPane | 
										aPane
											addChild: (BrButton new
													fitContent;
													aptitude: BrGlamorousButtonWithIconAndLabelAptitude;
													margin: (BlInsets right: 5);
													icon: BrGlamorousVectorIcons add;
													label: 'Make directory';
													action: [ :aButton | 
														aFileReference ensureCreateDirectory.
														aButton phlow fireToolUpdateWish ]).
										anIndex = aCount
											ifTrue: [ aPane
													addChild: (BrButton new
															fitContent;
															aptitude: BrGlamorousButtonWithIconAndLabelAptitude;
															icon: BrGlamorousVectorIcons add;
															label: 'Make empty file';
															action: [ :aButton | 
																aFileReference binaryWriteStreamDo: [ :aStream |  ].
																aButton phlow fireToolUpdateWish ]) ] ];
									yourself ] ] ];
		actionUpdateButton
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtPharoScriptFor: aView [
	<gtView>
	(self isFile and: [ self extension = 'st' or: [self extension = 'ph'] ]) ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Script';
		priority: 1;
		stencil: [ 
			(GtPharoSnippetCoder new 
				forSource: (self readStreamDo: [ :s | s contents ]);
				subscribeToSystem;
				asExpandedOnlyElement) 
					vFitContentLimited ];
		actionButtonLabel: 'File In' 
			action: [ :aButton :aTab | self asFileReference fileIn ];
		actionStencil: [ :tab | 
			BrButton new 
				aptitude: BrGlamorousButtonWithIconAptitude;
				label: 'Save';
				icon: BrGlamorousVectorIcons accept;
				action: [ | query newContents | 
					query := tab viewContentElement query // GtSourceCoderEditorId.
					newContents := query anyOne textualCoderViewModel styledText asString.
					self gtSaveContents: newContents ] ]
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtSaveContents: newContents [
	| newFile |
	newFile := self , 'new'.
	newFile ensureDelete.
	newFile writeStreamDo: [ :stream | stream nextPutAll: newContents ].
	self ensureDelete.
	newFile renameTo: self basename.
	^ newFile
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtSvgFor: aView [
	<gtView>
	(self isFile and: [ 
		self extension asLowercase = 'svg' ]) ifFalse: [ ^ aView empty ].

	^ aView explicit
		title: 'Svg';
		priority: 10;
		stencil: [
			(GtFileUtility svgElementFromFileReference: self) margin: (BlInsets all: 10) ]
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtTreeFor: aView [
	<gtView>
	(self isDirectory not or: [ self path isNetworkPath ])
		ifTrue: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Tree' translated;
		priority: 1;
		items: [ self gtChildren ];
		children: [ :each | each gtChildren ];
		column: 'Name' translated 
			icon: [ :each | 
				| anIcon aName aContainer |
				anIcon := each isDirectory
					ifTrue: [ BrGlamorousVectorIcons folder asElement ]
					ifFalse: [ BrGlamorousVectorIcons file asElement ].
				
				aName := GtPhlowUtility newItemLabel.
				aName text: each basename asString.
				
				aContainer := BrHorizontalPane new
					alignCenter;
					fitContent.
				
				aContainer addChild: anIcon; addChild: aName ]
			weight: 1;
		column: 'Size' translated
			text: [ :each | 
				[ 
					each isDirectory
						ifFalse: [  each humanReadableSize asString ]
						ifTrue: [ '--' ] ]
				on: FileException, FileSystemError
				do: [ :anException | anException return: '' ] ]
			width: 100;
		column: 'Creation' translated
			text: [ :each | 
				[ String
					streamContents: [ :s | 
						each creationTime printYMDOn: s.
						s nextPut: Character space.
						each creationTime printHMSOn: s ] ]
				on: FileException, FileSystemError
				do: [ :anException | anException return: '' ] ]
			width: 150;
		actionUpdateButton
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtZipItemsFor: aView [
	<gtView>
	(self isFile
		and: [ #('zip' 'jar' 'ear' 'war' 'mcz' 'xdoc') includes: self extension ])
		ifFalse: [ ^ aView empty ].
	^ aView columnedList
		title: 'Archive';
		priority: 10;
		items: [ | children root |
			root := (FileSystem zip: self) open workingDirectory.
			children := root directories , root files.
			children := self isRoot
				ifTrue: [ children ]
				ifFalse: [ children asOrderedCollection
						addFirst: self parent;
						yourself ] ];
		column: 'Icon' icon: [ :each | 
					each isDirectory
						ifTrue: [ BrGlamorousVectorIcons folder asElement ]
						ifFalse: [ BrGlamorousVectorIcons file asElement ]];
		column: 'Name'
			text: [ :each | 
				(self isChildOf: each)
					ifTrue: [ '..' ]
					ifFalse: [ each basename asString ] ];
		column: 'Size'
			text: [ :each | each humanReadableSize asString ];
		column: 'Creation' text: [ :each | 
			String
				streamContents: [ :s | 
					each creationTime printYMDOn: s.
					s nextPut: Character space.
					each creationTime printHMSOn: s ] ]
]
