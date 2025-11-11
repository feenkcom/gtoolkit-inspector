Class {
	#name : #GtCreator,
	#superclass : #Object,
	#traits : 'TGtPhlowWithSelfObjectHolder',
	#classTraits : 'TGtPhlowWithSelfObjectHolder classTrait',
	#instVars : [
		'source',
		'behavior',
		'selector',
		'label',
		'title'
	],
	#category : #'GToolkit-Inspector-Convenience and Utilities'
}

{ #category : #accessing }
GtCreator >> asElement [
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
GtCreator >> asMenuItem [
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
GtCreator >> behavior [
	^ behavior
]

{ #category : #accessing }
GtCreator >> behavior: anObject [
	behavior := anObject
]

{ #category : #compiling }
GtCreator >> compile [
	| model |
	model := RBNamespace new.
	(model classFor: self behavior) compile: source classified: self protocol.
	model changes gtExecuteWithUndo
]

{ #category : #accessing }
GtCreator >> defaultLabel [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtCreator >> empty [
	source := nil
]

{ #category : #accessing }
GtCreator >> gtDefaultInspectorTool [
	^ GtPhlowCompositeTool new
		addTool: (GtPhlowExplicitTool new
				name: 'View Source';
				stencil: [ self asElement ]);
		addTool: (super gtDefaultInspectorTool)
]

{ #category : #accessing }
GtCreator >> gtDisplayOn: stream [
	stream << self label asString
]

{ #category : #views }
GtCreator >> gtSourceFor: aView [
	<gtView>
	source ifNil: [ ^ aView empty ].
	
	^ aView textEditor
		title: 'Source string';
		styler: (BrRBTextStyler new
			 classOrMetaClass: self behavior);
		text: [ source ]
]

{ #category : #'as yet unclassified' }
GtCreator >> isValid [
	^ source notNil
]

{ #category : #accessing }
GtCreator >> label [
	^ label ifNil: [ self defaultLabel ]
]

{ #category : #accessing }
GtCreator >> label: anObject [
	label := anObject
]

{ #category : #private }
GtCreator >> newSelector [
	^ selector
		ifNil: [ | part index indexString newSelector |
			part := 'gt' , self selectorBase.
			index := 0.
			indexString := ''.
			[ behavior
				canUnderstand: (newSelector := (part , indexString , 'For:') asSymbol) ]
				whileTrue: [ index := index + 1.
					indexString := index printString ].
			selector := newSelector ]
]

{ #category : #private }
GtCreator >> object [
	^ nil
]

{ #category : #compiling }
GtCreator >> protocol [
	^ self subclassResponsibility
]

{ #category : #private }
GtCreator >> selectorBase [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtCreator >> source [
	^ source
]

{ #category : #accessing }
GtCreator >> source: aString [
	aString ifNil: [ ^ source := nil ].
	source := (RBParser parseMethod: aString) formattedCode
]

{ #category : #accessing }
GtCreator >> title [
	^ title ifNil: [ self selectorBase ]
]

{ #category : #accessing }
GtCreator >> title: anObject [
	title := anObject
]
