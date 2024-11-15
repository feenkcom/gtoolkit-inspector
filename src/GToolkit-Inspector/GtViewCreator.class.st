Class {
	#name : #GtViewCreator,
	#superclass : #Object,
	#instVars : [
		'source',
		'selector',
		'objectSource',
		'behavior',
		'title',
		'label'
	],
	#category : #'GToolkit-Inspector-Convenience and Utilities'
}

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
GtViewCreator class >> viewCreatorsFor: anObject forSource: sourceString in: aBehavior [
	| items |
	items := OrderedCollection new.
	((GtPhlowCollector new
		fromObject: anObject;
		pragmaName: #gtViewCreator;
		collectAllPragmas) collectAsSet: [ :each | each method selector ])
		do: [ :each | 
			| creator |
			creator := GtViewCreator new
					objectSource: sourceString;
					behavior: aBehavior.
			anObject perform: each with: creator.
			creator isValid ifTrue: [ items add: creator ] ].
	items
		addAll: ((((GtPhlowViewsCollector new from: anObject class) collectPragmas
				collect: [ :pragma | 
					{pragma method selector.
						(self titleFor: pragma method ast) ifNil: [ pragma method selector ]} ])
				asSortedCollection: [ :a :b | a second < b second ])
				collect: [ :each | 
					| creator |
					creator := self new.
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
	^ items
]

{ #category : #accessing }
GtViewCreator >> asElement [
	| pane valueHolder newMethodElement |
	pane := BrVerticalPane new.
	pane padding: (BlInsets all: 10).
	pane hMatchParent.
	pane vFitContentLimited.
	valueHolder := ValueHolder new.
	valueHolder
		contents: ((GtPharoMethodCoder forClass: self behavior source: source)
				protocol: #views;
				asCoderViewModel).
	valueHolder contents shouldHaveHeader: false.
	newMethodElement := GtPharoNewMethodCoderElement new
			hMatchParent;
			vFitContentLimited;
			behavior: self behavior;
			methodCoderViewModelValueHolder: valueHolder;
			onMethodCoderSaved: [ :event :viewModel | pane enqueueTask: [ pane fireEvent: BrContextMenuHideWish new ] asBlTask ];
			when: GtPhlowObjectToSpawn do: [ :aSpawnEvent | aSpawnEvent consumed: true ].
	pane addChild: newMethodElement.
	^ pane
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
	source := String
			streamContents: [ :stream | 
				stream << self newSelector
					<< ' aView
	<gtView>
	^ aView forward
		title: ''' << self title
					<< ''';
		object: [ ' << objectSource
					<< ' ];
		view: #' << aSymbol ]
]

{ #category : #accessing }
GtViewCreator >> empty [
	source := nil
]

{ #category : #accessing }
GtViewCreator >> gtDefaultInspectorTool [
	^ GtPhlowCompositeTool new
		addTool: (GtPhlowExplicitTool new
				name: self gtDisplayString;
				stencil: [ self asElement ])
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
			aptitude := BrGlamorousWithContextMenuAptitude
					handle: [ BlElement new
							size: 8 @ 8;
							yourself ] asStencil
					content: [ | element |
						element := self asElement.
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
			aptitude position: anElement boundsInSpace bottomCenter.
			anElement addAptitude: aptitude.
			aptitude show ] asBlTask
]

{ #category : #accessing }
GtViewCreator >> source [
	^ source
]

{ #category : #accessing }
GtViewCreator >> source: anObject [
	source := anObject
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
