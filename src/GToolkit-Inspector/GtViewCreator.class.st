Class {
	#name : #GtViewCreator,
	#superclass : #Object,
	#instVars : [
		'variable',
		'object',
		'source',
		'selector'
	],
	#category : #'GToolkit-Inspector-Convenience and Utilities'
}

{ #category : #'instance creation' }
GtViewCreator class >> forCollection: varName in: anObject [
	^ self new
		variable: varName;
		object: anObject;
		createSourceForCollection;
		yourself
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
	^ object class whichClassDefinesInstVar: variable
]

{ #category : #compiling }
GtViewCreator >> compile [
	| model |
	model := RBNamespace new.
	(model classFor: self behavior) compile: source classified: #views.
	model changes gtExecuteWithUndo
]

{ #category : #private }
GtViewCreator >> createSourceForCollection [
	source := (object instVarNamed: variable) gtCreateViewSource
			expandMacrosWith: self newSelector
			with: variable
			with: variable capitalized
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
	stream << 'Create gtView method on ' << variable << ' in '
		<< self behavior name
]

{ #category : #private }
GtViewCreator >> newSelector [
	^ selector
		ifNil: [ | part index indexString newSelector |
			part := 'gt' , variable capitalized.
			index := 0.
			indexString := ''.
			[ object respondsTo: (newSelector := (part , indexString , 'For:') asSymbol) ]
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
GtViewCreator >> variable [
	^ variable
]

{ #category : #accessing }
GtViewCreator >> variable: anObject [
	variable := anObject
]
