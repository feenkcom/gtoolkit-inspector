Extension { #name : #AbstractFileReference }

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtActionMaterializeFuelFor: anAction [
	<gtAction>
	|  button |
	(self exists not or: [ (self extension = 'fuel') not]) ifTrue: [ ^ anAction noAction].
	^ anAction explicit stencil: [
		button := BrButton new.
		button
		look: BrGlamorousButtonWithIconLook;
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
		look: BrGlamorousButtonWithIconLook;
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
AbstractFileReference >> gtContentsFor: aView [
	<gtView>
	self isFile ifFalse: [ ^ aView empty ].
	[ self readStreamDo: [ :s | s next: 1000 ] ]
		on: ZnInvalidUTF8
		do: [ ^ aView empty ].
	^ aView explicit
		title: 'Contents' translated;
		priority: 50;
		stencil: [ 
			BrEditorElement new 
				padding: (BlInsets all: 10);
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ];
				editor: (BrTextEditor new 
					text: (BlRopeableCollectionFile ropeFor: self) glamorousRegularFont) ];
		actionStencil: [ :tab | 
			BrButton new 
				look: BrGlamorousButtonWithIconLook;
				icon: BrGlamorousVectorIcons accept;
				action: [ 
					| newContents | 
					newContents := tab viewContentElement children first editor text asString.
					(self fullName, '.backup') asFileReference ensureDelete.
					self copyTo: (self fullName, '.backup') asFileReference.
					self ensureDelete; writeStreamDo: [ :s | s nextPutAll: newContents ] ] ]
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtFigureFor: aView [
	<gtView>
	(self isFile and: [ 
		(ImageReadWriter allTypicalFileExtensions includes: self extension asLowercase) ]) ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Picture';
		priority: 10;
		stencil: [ GtFileUtility imageElementFromFileReference: self ]
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtHexContentsFor: aView [
	<gtView>
	self isFile ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Hex' translated;
		priority: 90;
		stencil: [ 
			| displayString  |
			displayString := ''.
			(self binaryReadStreamDo: [ :stream | 
				| displayStream maxBytes buffer |
				maxBytes := 10000.
				buffer := stream next: maxBytes.
				displayStream := (String new: maxBytes * 5) writeStream.
				buffer hexDumpOn: displayStream max: maxBytes.
				displayString := displayStream contents asText ]).
			
			BrEditorElement new 
				padding: (BlInsets all: 10);
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ];
				editor: (BrTextEditor new 
					text: displayString asRopedText glamorousMonospace) ]
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtItemsFor: aView [
	<gtView>
	|fileBrowser|
	self isDirectory
		ifFalse: [ ^ aView empty ].
	"fileBrowser := BrFileBrowser new.
	fileBrowser folder: self.
	^ aView explicit
		title: 'Items' translated;
		priority: 10;
		stencil: fileBrowser"
	^ aView columnedList
		title: 'Items' translated;
		priority: 10;
		items: [ | children |
			children := (self directories sorted: [:a :b | a basename < b basename ]) , (self files sorted: [:a :b | a basename < b basename ]).
			children := self isRoot
				ifTrue: [ children ]
				ifFalse: [ children asOrderedCollection
						addFirst: self parent;
						yourself ].
			children ];
		column: 'Icon' translated 
			icon: [ :each | 
				each isDirectory
					ifTrue: [ BrGlamorousIcons folder ]
					ifFalse: [ BrGlamorousIcons file ] ];
		column: 'Name' translated text: [ :each | 
			(self isChildOf: each)
				ifTrue: [ '..' ]
				ifFalse: [ each basename asString ] ];
		column: 'Size' translated
			text: [ :each | each humanReadableSize asString ]
			width: 100;
		column: 'Creation' translated
			text: [ :each | 
				String
					streamContents: [ :s | 
						each creationTime printYMDOn: s.
						s nextPut: Character space.
						each creationTime printHMSOn: s ] ]
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtJsonFor: aView [
	<gtView>
	(self isFile and: [ (GtFileUtility mimeTypeOfExtension: self extension) 
		= ZnMimeType applicationJson ]) ifFalse: [ ^ aView empty ].
	^ aView textEditor
		title: 'JSON';
		priority: 1;
		actionButtonIcon: BrGlamorousIcons tree 
			action: [ :aButton | 
				aButton phlow spawnObject: (
					STONJSON fromString: self contents) ];
		look: [ BrGlamorousCodeEditorLook ];
		styler: [ JSONParser gtStyler ];
		text: [ (STONJSON toStringPretty: (
			STONJSON fromString: self contents)) ]
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtPathFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Path';
		priority: 55;
		items: [ self asFileReference withParents ];
		column: 'Icon' icon: [ :aFileReference |
			aFileReference exists 
				ifTrue: [ 
					(GtInspectorAcceptIconStencil new 
						radius: 8; 
						thickness: 2) asElement 
						background: BrGlamorousColors successBackgroundColor ]
				ifFalse: [ 
					(GtInspectorPlusIconStencil close 
						radius: 8; 
						thickness: 2) asElement 
						background: BrGlamorousColors errorBackgroundColor] ]
			width: 35;
		column: 'Name' text: [ :aFileReference | 
			aFileReference basename, 
				(aFileReference isDirectory 
					ifTrue: ['/'] 
				ifFalse: ['']) ]
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtPharoScriptFor: aView [
	<gtView>
	(self isFile and: [ self extension = 'st' or: [self extension = 'ph'] ]) ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Script';
		priority: 10;
		stencil: [ 
			GtCoderSnippet new 
				sourceCode: (self readStreamDo: [ :s | s contents ]);
				asElement ];
		actionButtonLabel: 'File In' 
			action: [ :aButton :aTab | self asFileReference fileIn ]
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
						ifTrue: [ BrGlamorousIcons folder asElement ]
						ifFalse: [ BrGlamorousIcons file asElement ]];
		column: 'Name'
			item: [ :each | 
				(self isChildOf: each)
					ifTrue: [ '..' ]
					ifFalse: [ each basename asString ] ];
		column: 'Size'
			item: [ :each | each humanReadableSize asString ];
		column: 'Creation' item: [ :each | 
			String
				streamContents: [ :s | 
					each creationTime printYMDOn: s.
					s nextPut: Character space.
					each creationTime printHMSOn: s ] ]
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> withParents [
	<return: #Array of: #FileReference>
	| anAbsolutePath |
	anAbsolutePath := self withPath: self absolutePath.
	^ Array streamContents: [ :aStream | 
		anAbsolutePath withParentsInto: aStream.
		aStream nextPut: anAbsolutePath ]
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> withParentsInto: aStream [
	<return: #Array of: #FileReference>
	"I should be called on file references with absolute paths, otherwise an infinite loop happens"
	| aParent |
	aParent := self parent.
	aParent isRoot ifFalse: [
		aParent withParentsInto: aStream ].
	aStream nextPut: aParent
]
