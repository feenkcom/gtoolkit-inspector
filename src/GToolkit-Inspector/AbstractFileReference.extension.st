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
	| button |
	self exists ifFalse: [ ^ anAction noAction ].

	^ anAction button
		  icon: BrGlamorousIcons go;
		  tooltip: 'Open in OS';
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
					text: (BlRopedText file: self) glamorousRegularFont) ];
		actionStencil: [ :tab | 
			BrButton new 
				aptitude: BrGlamorousButtonWithIconAptitude;
				label: 'Save';
				icon: BrGlamorousVectorIcons accept;
				action: [ 
					| newContents | 
					newContents := tab viewContentElement children first children first editor text asString.
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

	^ aView columnedList
		title: 'Items' translated;
		priority: 10;
		items: [ self gtChildrenWithParent ];
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
			text: [ :each | 
				[ each isDirectory 
					ifTrue: [ '' ]
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
			width: 150
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
		aptitude: [ BrGlamorousCodeEditorAptitude ];
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
				action: [ 
					| newContents | 
					newContents := tab viewContentElement children first children first children first textualCoderViewModel styledText asString.
					(self fullName, '.backup') asFileReference ensureDelete.
					self copyTo: (self fullName, '.backup') asFileReference.
					self ensureDelete; writeStreamDo: [ :s | s nextPutAll: newContents ] ] ]
]

{ #category : #'*GToolkit-Inspector' }
AbstractFileReference >> gtTreeFor: aView [
	<gtView>
	self isDirectory
		ifFalse: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Tree' translated;
		priority: 15;
		items: [ self gtChildren ];
		children: [ :each | each gtChildren ];
		column: 'Name' translated 
			icon: [ :each | 
				| anIcon aName aContainer |
				anIcon := each isDirectory
					ifTrue: [ BrGlamorousIcons folder asElement ]
					ifFalse: [ BrGlamorousIcons file asElement ].
				
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
						ifTrue: [ '' ] ]
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
			width: 150
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
