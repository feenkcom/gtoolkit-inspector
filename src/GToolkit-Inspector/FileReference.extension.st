Extension { #name : #FileReference }

{ #category : #'*GToolkit-Inspector' }
FileReference >> gtActionMaterializeFuelFor: anAction [
	<gtAction>
	|  button |
	(self exists not or: [ (self extension = 'fuel') not]) ifTrue: [ ^ anAction noAction].
	^ anAction explicit stencil: [
		button := BrButton new.
		button
		look: BrGlamorousButtonWithIconLook;
		action:  [
				button fireEvent: (GtPhlowObjectToSpawn new
				object: (FLMaterializer materializeFromFileNamed: self fullName);
				sourceElement: button) ];
		icon: BrGlamorousIcons play asElement;
		label: 'Parse using GToolkit Documenter' translated.
	]
]

{ #category : #'*GToolkit-Inspector' }
FileReference >> gtActionMaterializeXdFileFor: anAction [
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
			button fireEvent: (GtPhlowObjectToSpawn new
						object: xdFile;
						sourceElement: button) ];
		icon: BrGlamorousIcons play asElement;
		label: 'Materialize xdoc file' translated.
	]
]

{ #category : #'*GToolkit-Inspector' }
FileReference >> gtContentsFor: aView [
	<gtView>
	self isFile ifFalse: [ ^ aView empty ].
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
					text: (self binaryReadStreamDo: [ :stream | 
						[stream contents ]
							on: Error 
							do: [ (stream next: 10000) asString ] ]) asRopedText glamorousRegularFont) ];
		actionStencil: [ :tab | 
			BrButton new 
				look: BrGlamorousButtonWithIconLook;
				icon: BrGlamorousIcons accept asElement;
				action: [ 
					| newContents | 
					newContents := tab viewContentElement editor text asString.
					(self fullName, '.backup') asFileReference ensureDelete.
					self copyTo: (self fullName, '.backup') asFileReference.
					self ensureDelete; writeStreamDo: [ :s | s nextPutAll: newContents ] ] ]
]

{ #category : #'*GToolkit-Inspector' }
FileReference >> gtFigureFor: aView [
	<gtView>
	(self isFile and: [ self mimeTypes notNil and: [ 
			self mimeTypes anySatisfy: [ :eachMimeType |  
				eachMimeType matches: (ZnMimeType main: 'image' sub: '*') ] ] ]) ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Picture';
		priority: 10;
		stencil: [ GtFileUtility imageElementFromFileReference: self ]
]

{ #category : #'*GToolkit-Inspector' }
FileReference >> gtItemsFor: aView [
	<gtView>
	self isDirectory
		ifFalse: [ ^ aView empty ].
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
			do: [ :column | 
			column
				item: [ :each | 
					each isDirectory
						ifTrue: [ BrGlamorousIcons folder ]
						ifFalse: [ BrGlamorousIcons file ] ];
				rowStencil: [ :eachIcon | eachIcon asElement margin: (BlInsets left: 5 right: 5) ];
				noResize ];
		column: 'Name' translated
			do: [ :column | 
			column
				item: [ :each | 
					(self isChildOf: each)
						ifTrue: [ '..' ]
						ifFalse: [ each basename asString ] ];
				matchParent ];
		column: 'Size' translated
			do:
				[ :column | column item: [ :each | each humanReadableSize asString ] ];
		column: 'Creation' translated
			do: [ :column | 
			column
				item: [ :each | 
					String
						streamContents: [ :s | 
							each creationTime printYMDOn: s.
							s nextPut: Character space.
							each creationTime printHMSOn: s ] ] ]
]

{ #category : #'*GToolkit-Inspector' }
FileReference >> gtPathFor: aView [
	<gtView>
	^ aView explicit
		title: 'Path';
		priority: 55;
		stencil: [ 
			| all container |
			all := self fullPath withParents collect: #asFileReference.
			container := BlElement new
				layout: BlLinearLayout vertical;
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent ].
			all doWithIndex: [ :aFileReference :index |
				| icon |
				icon := aFileReference exists 
					ifTrue: [ 
						(GtInspectorAcceptIconStencil new radius: 8; thickness: 2) asElement background: 
						BrGlamorousColors successBackgroundColor ] 
					ifFalse: [ 
						(GtInspectorPlusIconStencil close radius: 8; thickness: 2) asElement background: BrGlamorousColors errorBackgroundColor].
				container addChild: (
					BlElement new
						when: BlClickEvent do: [:event | event target phlow spawnObject: aFileReference ];
						constraintsDo: [ :c |
							c frame horizontal alignCenter.
							c frame vertical alignCenter.
							c horizontal fitContent.
							c vertical fitContent ];
						layout: BlLinearLayout horizontal;
						addChild: (icon
							constraintsDo: [ :c | c frame vertical alignCenter];
							margin: (BlInsets top: 20 left: 20 bottom: 0 right: 0));
						addChild: (BrLabel new
							constraintsDo: [ :c | c frame vertical alignCenter];
							text: (aFileReference basename, (all size > index ifTrue: ['/'] ifFalse: ['']));
							look: BrGlamorousLabelLook;
							margin: (BlInsets top: 20 left: 10 bottom: 0 right: 0))) ].
			container ]
]

{ #category : #'*GToolkit-Inspector' }
FileReference >> gtPharoScriptFor: aView [
	<gtView>
	(self isFile and: [ self extension = 'st' or: [self extension = 'ph'] ]) ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Script';
		priority: 10;
		stencil: [ 
			GtCoderSnippet new 
				sourceCode: (self readStreamDo: [ :s | s contents ]);
				asElement ]
]

{ #category : #'*GToolkit-Inspector' }
FileReference >> gtZipItemsFor: aView [
	<gtView>
	(self isFile and: [ #('zip' 'jar' 'ear' 'war' 'mcz' 'xdoc') includes: self extension ]) ifFalse: [ ^ aView empty ].
	^ aView columnedList
		title: 'Archive';
		priority: 10;
		items: [ 
			| list children root |
			root := (FileSystem zip: self) open workingDirectory.
			children := root directories, root files.
			children := self isRoot 
				ifTrue: [ children ]
				ifFalse: [ children asOrderedCollection addFirst: self parent; yourself ] ];
		column: 'Icon' do: [ :aColumn | 
				aColumn itemStencil: [ :each :index |
					(BrImageStencil new 
						image: (each isDirectory 
							ifTrue: [ BrGlamorousIcons folder ]
							ifFalse: [ BrGlamorousIcons file ]);
						asElement)
						margin: (BlInsets left: 5 right: 5) ];
					noResize ];
		column: 'Name' do: [:aColumn | 
				aColumn item: [ :each | 
					(self isChildOf: each) 
						ifTrue: [ '..' ]
						ifFalse: [ each basename asString ] ] ];
		column: 'Size' do: [ :aColumn |
				aColumn item: [:each |  
					each humanReadableSize asString ] ];
		column: 'Creation' do: [ :aColumn |
				aColumn item: [ :each | 
					String streamContents: [:s | 
						each creationTime printYMDOn: s.
						s nextPut: Character space.
						each creationTime printHMSOn: s ] ] ]
]
