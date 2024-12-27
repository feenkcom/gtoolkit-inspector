Class {
	#name : #GtViewCreator,
	#superclass : #Object,
	#traits : 'TGtCoderWithSelfObjectHolder',
	#classTraits : 'TGtCoderWithSelfObjectHolder classTrait',
	#instVars : [
		'source',
		'selector',
		'objectSource',
		'behavior',
		'title',
		'label',
		'object'
	],
	#category : #'GToolkit-Inspector-Convenience and Utilities'
}

{ #category : #private }
GtViewCreator class >> addTemporariesTo: aString for: aBehavior [
	| ast vars |
	ast := RBParser parseExpression: aString.
	ast isSequence ifFalse: [ ast := RBSequenceNode statements: {ast} ].
	vars := Set new.
	ast
		nodesDo: [ :each | 
			(each isVariable
				and: [ (each whoDefines: each name) isNil
						and: [ each isSelfOrSuperVariable not and: [ each name first isLowercase ] ] ])
				ifTrue: [ vars add: each name asString ] ].
	aBehavior allInstVarNames
		do: [ :each | vars remove: each asString ifAbsent: [  ] ].
	aBehavior allClassVarNames
		do: [ :each | vars remove: each asString ifAbsent: [  ] ].
	vars do: [ :each | ast addTemporaryNamed: each ].
	^ ast formattedCode
]

{ #category : #private }
GtViewCreator class >> forwardViewCreatorsForObject: anObject andSource: sourceString in: aBehavior [
	| forwardItems ignoredSelectors selectors |
	forwardItems := OrderedCollection new.
	ignoredSelectors := self ignoredForwardSelectors.
	selectors := (GtPhlowViewsCollector new from: anObject class) collectPragmas
			collectAsSet: [ :each | each method selector ].
	ignoredSelectors do: [ :each | selectors remove: each ifAbsent: [  ] ].
	forwardItems
		addAll: (((selectors
				collect: [ :sel | 
					{sel.
						(self titleFor: (anObject class lookupSelector: sel) ast) ifNil: [ sel ]} ])
				asSortedCollection: [ :a :b | a second < b second ])
				collect: [ :each | 
					| creator |
					creator := self new.
					creator object: anObject.
					creator objectSource: sourceString.
					creator behavior: aBehavior.
					creator
						title: (creator variable
								ifNil: [ each second ]
								ifNotNil: [ :v | v capitalized , ' ' , each second uncapitalized ]).
					creator
						label: ('Create <gtView> forward to ' , each second) asRopedText glamorousRegularFont.
					creator createSourceForForwarder: each first.
					creator ]).
	^ forwardItems
]

{ #category : #private }
GtViewCreator class >> ignoredForwardSelectors [
	^ #(gtRawFor: gtPrintFor: gtMetaFor:)
]

{ #category : #private }
GtViewCreator class >> localViewCreatorsForObject: anObject andSource: sourceString in: aBehavior [
	| items |
	items := OrderedCollection new.
	((GtPhlowCollector new
		fromObject: anObject;
		pragmaName: #gtViewCreator;
		collectAllPragmas) collectAsSet: [ :each | each method selector ])
		do: [ :each | 
			| creator |
			creator := self new
					object: anObject;
					objectSource: sourceString;
					behavior: aBehavior.
			anObject perform: each with: creator.
			creator isValid ifTrue: [ items add: creator ] ].
	^ items
]

{ #category : #private }
GtViewCreator class >> titleFor: aNode [
	aNode
		nodesDo: [ :each | 
			(each isMessage and: [ each selector = #title: ])
				ifTrue: [ (each arguments first isLiteralNode
						and: [ each arguments first value isString ])
						ifTrue: [ ^ each arguments first value ] ] ].
	^ nil
]

{ #category : #accessing }
GtViewCreator class >> viewCreatorsForObject: anObject andSource: aString in: aBehavior [
	^ [ | localItems forwardItems sourceString |
	sourceString := self addTemporariesTo: aString for: aBehavior.
	localItems := self
			localViewCreatorsForObject: anObject
			andSource: sourceString
			in: aBehavior.
	forwardItems := self
			forwardViewCreatorsForObject: anObject
			andSource: sourceString
			in: aBehavior.
	localItems , forwardItems ] on: Error do: [ :ex | ex return: #() ]
]

{ #category : #accessing }
GtViewCreator >> asElement [
	| pane valueHolder newMethodElement coder |
	pane := BrVerticalPane new.
	pane padding: (BlInsets all: 10).
	pane hMatchParent.
	pane vFitContentLimited.
	valueHolder := ValueHolder new.
	coder := GtPharoMethodCoder forClass: self behavior source: source.
	coder protocol: #views.
	valueHolder contents: coder asCoderViewModel.
	valueHolder contents shouldHaveHeader: false.
	newMethodElement := GtPharoNewMethodCoderElement new
			hMatchParent;
			vFitContentLimited;
			selfObject: self object;
			behavior: self behavior;
			methodCoderViewModelValueHolder: valueHolder;
			onMethodCoderSaved: [ :event :viewModel | pane enqueueTask: [ pane fireEvent: BrContextMenuHideWish new ] asBlTask ];
			when: GtPhlowObjectToSpawn do: [ :aSpawnEvent | aSpawnEvent consumed: true ].
	pane userData at: #coder put: coder.
	pane addChild: newMethodElement.
	^ pane
]

{ #category : #converting }
GtViewCreator >> asMenuItem [
	| coder coderViewModel menu |
	coder := GtPharoMethodCoder forClass: self behavior source: source.
	coder protocol: #views.
	coderViewModel := coder asCoderViewModel.
	coderViewModel selfObjectHolder: self selfObjectHolder.
	menu := GtPharoNewMethodCoderMenu new
		coderViewModel: coderViewModel;
		onMethodCoderSaved: [ :event :viewModel :element | ];
		onObjectToSpawn: [ :aSpawnEvent | ].
	^ BrMenuSubmenuItem new
		bePinSubmenuAction;
		hideOnClick: true;
		label: self label;
		submenu: menu;
		group: BrMenuItemGroupConfiguration refactoring
]

{ #category : #accessing }
GtViewCreator >> behavior [
	^ behavior
]

{ #category : #accessing }
GtViewCreator >> behavior: anObject [
	behavior := anObject
]

{ #category : #compiling }
GtViewCreator >> compile [
	| model |
	model := RBNamespace new.
	(model classFor: self behavior) compile: source classified: #views.
	model changes gtExecuteWithUndo
]

{ #category : #private }
GtViewCreator >> createSourceForForwarder: aSymbol [
	self
		source: (String
				streamContents: [ :stream | 
					stream << self newSelector
						<< ' aView
	<gtView>
	^ aView forward
		title: ''' << self title
						<< ''';
		object: [ ' << objectSource
						<< ' ];
		view: #' << aSymbol ])
]

{ #category : #accessing }
GtViewCreator >> empty [
	source := nil
]

{ #category : #private }
GtViewCreator >> evaluateView: aString [
	| ast rewriter method |
	ast := RBParser parseMethod: aString.
	rewriter := RBParseTreeRewriter new replace: objectSource with: 'self'.
	(rewriter executeTree: ast) ifTrue: [ ast := rewriter tree ].
	method := Smalltalk compiler
			environment: behavior environment;
			class: behavior;
			source: ast formattedCode;
			compile.
	^ method valueWithReceiver: object arguments: {GtPhlowEmptyView new}
]

{ #category : #accessing }
GtViewCreator >> gtDefaultInspectorTool [
	^ GtPhlowCompositeTool new
		addTool: (GtPhlowExplicitTool new
				name: self gtDisplayString;
				stencil: [ self asElement ]);
		addTool: (super gtDefaultInspectorTool)
]

{ #category : #accessing }
GtViewCreator >> gtDisplayOn: stream [
	stream << self label asString
]

{ #category : #'as yet unclassified' }
GtViewCreator >> isValid [
	^ source notNil
]

{ #category : #accessing }
GtViewCreator >> label [
	^ label
		ifNil: [ title
				ifNil: [ self variable
						ifNil: [ 'Create <gtView>' ]
						ifNotNil: [ :v | 'Create <gtView> for ' , v ] ]
				ifNotNil: [ 'Create <gtView> ' , title ] ]
]

{ #category : #accessing }
GtViewCreator >> label: anObject [
	label := anObject
]

{ #category : #private }
GtViewCreator >> newSelector [
	^ selector
		ifNil: [ | part index indexString newSelector |
			part := 'gt' , (self variable ifNil: [ 'View' ]) capitalized.
			index := 0.
			indexString := ''.
			[ behavior
				canUnderstand: (newSelector := (part , indexString , 'For:') asSymbol) ]
				whileTrue: [ index := index + 1.
					indexString := index printString ].
			selector := newSelector ]
]

{ #category : #accessing }
GtViewCreator >> object [
	^ object
]

{ #category : #accessing }
GtViewCreator >> object: anObject [
	object := anObject
]

{ #category : #accessing }
GtViewCreator >> objectSource [
	^ objectSource
]

{ #category : #accessing }
GtViewCreator >> objectSource: anObject [
	objectSource := anObject
]

{ #category : #view }
GtViewCreator >> showOn: anElement [
	anElement
		enqueueTask: [ | aptitude |
			aptitude := BrGlamorousWithTooltipAptitude
					handle: [ BlElement new
							size: 8 @ 8;
							yourself ] asStencil
					content: [ | element coder |
						element := self asElement.
						coder := element userData at: #coder.
						coder addOns
							addContextAction: 'Inspect view' translated
								icon: BrGlamorousVectorIcons playinspect
								action: [ :aCoderUIModel :button | anElement phlow spawnObject: (self evaluateView: coder currentSourceString) ];
							addStyler: (GtViewStyler new object: self object).
						element width: 450.
						element
							when: BlElementRemovedFromSceneGraphEvent
							do: [ :event | anElement removeAptitude: aptitude ].
						element when: BlElementAddedToSceneGraphEvent do: [ :event | element ].
						element
							childWithId: GtSourceCoderEditorId
							ifFound: [ :editor | editor enqueueTask: [ editor requestFocus ] asBlTask ]
							ifNone: [  ].
						element ].
			aptitude hideDelay: nil.
			anElement addAptitude: aptitude.
			aptitude show ] asBlTask
]

{ #category : #accessing }
GtViewCreator >> source [
	^ source
]

{ #category : #accessing }
GtViewCreator >> source: aString [
	aString ifNil: [ ^ source := nil ].
	source := (RBParser parseMethod: aString) formattedCode
]

{ #category : #accessing }
GtViewCreator >> title [
	^ title
		ifNil: [ self variable ifNotNil: [ :v | v capitalized ] ifNil: [ 'View' ] ]
]

{ #category : #accessing }
GtViewCreator >> title: anObject [
	title := anObject
]

{ #category : #accessing }
GtViewCreator >> variable [
	| ast |
	ast := GtPharoParser
			parseWithErrors: objectSource
			startingAt: GtPharoParser startingStateForMethodSequence.
	(ast isSequence and: [ ast statements size = 1 ])
		ifTrue: [ ast := ast statements first ].
	ast isVariable ifTrue: [ ^ ast variableName ].
	^ nil
]
