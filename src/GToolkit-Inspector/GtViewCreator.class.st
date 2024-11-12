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

{ #category : #'as yet unclassified' }
GtViewCreator >> compile [
	| model |
	model := RBNamespace new.
	(model classFor: self behavior) compile: source classified: #views.
	model changes gtExecuteWithUndo
]

{ #category : #'instance creation' }
GtViewCreator >> createSourceForCollection [
	source := String
			streamContents: [ :stream | 
				stream << self newSelector
					<< ' aView
	<gtView>
	' << variable
					<< ' ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: ''' << variable capitalized
					<< ''';
		items: [ ' << variable
					<< ' ];
		column: ''Value'' text: [:each | each gtDisplayString]' ]
]

{ #category : #accessing }
GtViewCreator >> gtDefaultInspectorTool [
	^ GtPhlowCompositeTool new
		addTool: (GtPhlowExplicitTool new
				name: self gtDisplayString;
				stencil: [ self asElement ])
]

{ #category : #'as yet unclassified' }
GtViewCreator >> gtDisplayOn: stream [
	stream << 'Create gtView method on ' << variable << ' in '
		<< self behavior name
]

{ #category : #'instance creation' }
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

{ #category : #accessing }
GtViewCreator >> variable [
	^ variable
]

{ #category : #accessing }
GtViewCreator >> variable: anObject [
	variable := anObject
]
