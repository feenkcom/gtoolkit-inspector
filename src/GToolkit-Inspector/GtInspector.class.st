"
I am an object inspector.
I display an object.
I use {{gtMethod:GtInspectorObject>>#asElementDo:}} to generate the object inspector widget.

{{gtExample:GtInspectorExamples>>#inspectorElement|previewExpanded}}


"
Class {
	#name : #GtInspector,
	#superclass : #GtInspectorObjectElement,
	#traits : 'TGtPagerWindowOpener',
	#classTraits : 'TGtPagerWindowOpener classTrait',
	#instVars : [
		'contentElement',
		'playgroundElement',
		'titleNotifier',
		'playgroundPageStrategy',
		'databasesRegistry',
		'externalSnippetContext'
	],
	#classVars : [
		'IndexableDisplayLimit'
	],
	#classInstVars : [
		'embeddedPlaygroundName'
	],
	#category : #'GToolkit-Inspector-! Core'
}

{ #category : #accessing }
GtInspector class >> embeddedPlaygroundName [
	^ embeddedPlaygroundName
]

{ #category : #accessing }
GtInspector class >> embeddedPlaygroundName: aClassName [
	embeddedPlaygroundName := aClassName
]

{ #category : #accessing }
GtInspector class >> extensionsPragma [
	^ #gtView
]

{ #category : #'api - instance creation' }
GtInspector class >> forObject: anObject [
	^ self new object: anObject
]

{ #category : #'instance creation' }
GtInspector class >> forObject: anObject viewSelector: aSymbol [ 

	^ self new 
		object: anObject viewSelector: aSymbol
]

{ #category : #'gt-extensions' }
GtInspector class >> gtActionsFor: aView [
	<gtView>
	<gtClassView>
	^ (#gtAction gtPragmas gtItemsFor: aView)
		title: 'Actions';
		priority: 35
]

{ #category : #'gt-extensions' }
GtInspector class >> gtExtensionsFor: aView [
	<gtView>
	<gtClassView>
	
	^ (self extensionsPragma gtPragmas gtItemsFor: aView)
		title: 'Extensions';
		priority: 34
]

{ #category : #inspecting }
GtInspector class >> gtSpotterExtensionsFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 50;
		items: [ self inspectorExtendingMethods ];
		title: 'Extensions';
		itemName: [ :each | each gtDisplayString ];
		filterBySubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #settings }
GtInspector class >> indexableDisplayLimit [
	^ IndexableDisplayLimit ifNil: [ 5000 ]
]

{ #category : #settings }
GtInspector class >> indexableDisplayLimit: anInteger [
	IndexableDisplayLimit := anInteger
]

{ #category : #inspecting }
GtInspector class >> inspectorExtendingMethods [
	^ ((Pragma allNamed: self extensionsPragma)
		collect: [ :p | p method asRingDefinition ]) sorted
]

{ #category : #'gt-extensions' }
GtInspector class >> inspectorViews [
	<gtExample>
	^ #gtView gtPragmas
]

{ #category : #'api - instance creation' }
GtInspector class >> newOn: anObject [
	"create an inspector element on a given object"
	^ self forObject: anObject 
]

{ #category : #'private - accessing' }
GtInspector >> contentElement [
	<rerturn: #GtInspectorContentElement>
	^ contentElement
]

{ #category : #accessing }
GtInspector >> databasesRegistry: aDatabaseRegistry [
	databasesRegistry := aDatabaseRegistry.
	
	self updatePlaygroundDatabasesRegistry.
]

{ #category : #accessing }
GtInspector >> externalSnippetContext: anExternalSnippetContext [
	externalSnippetContext := anExternalSnippetContext.
	
	self updateExternalSnippetContext.
]

{ #category : #initialization }
GtInspector >> initialize [
	super initialize.

	self initializeTitleNotifier.
	self initializeContentElement.
	self initializePlaygroundElement.
	
	self layout: BlLinearLayout vertical.
	self beFocusable.
	self addChild: self contentElement as: #content.
	self addChild: self playgroundElement as: #playground.
	self initializeListeners.
	self matchParent.
	self playgroundElement collapse.
]

{ #category : #initialization }
GtInspector >> initializeContentElement [
	contentElement := GtInspectorContentElement new.
]

{ #category : #initialization }
GtInspector >> initializeListeners [
	self when: GtPagerPageAddedEvent do: [ :anEvent | 
		self onAddedToPager: anEvent pager ].
	self when: GtPagerPageRemovedEvent do: [ :anEvent | 
		self onRemovedFromPager: anEvent pager ].
	self when: BrPhlowToolUpdateWish do: [ :anEvent | 
		self onUpdateWish: anEvent ].
	self when: BlClickEvent do: [ self requestFocus ].
]

{ #category : #initialization }
GtInspector >> initializePlaygroundElement [
	playgroundElement := (self class environment at: self class embeddedPlaygroundName) new
]

{ #category : #initialization }
GtInspector >> initializeTitleNotifier [
	titleNotifier := GtPhlowTitleIconAndLabelNotifier new
		longLabel: [ self object gtInspectorTitleString ];
		icon: BrGlamorousVectorIcons inspect.
	self addEventHandler: titleNotifier.
]

{ #category : #accessing }
GtInspector >> object: anObject viewSelector: aSymbol [

	| anObjectHolder |
	anObjectHolder := GtInspectorObject new
		                  object: anObject;
		                  viewSelector: aSymbol.
	self objectHolder: anObjectHolder
]

{ #category : #'private - event handling' }
GtInspector >> onAddedToPager: aGtPager [
	"Inspector was added to a pager"
	self phlow
		firstChildWithCompositeViewDo: [ :aTabGroup | 
			aGtPager context inspectorTabSelector
				selectTabIn: aTabGroup on: self object ].
]

{ #category : #'private - hooks' }
GtInspector >> onObjectHolderChanged [
	super onObjectHolderChanged.
	
	self contentElement objectHolder: self objectHolder.
	self playgroundElement objectHolder: self objectHolder.
]

{ #category : #'private - event handling' }
GtInspector >> onRemovedFromPager: aGtPager [
	"Inspector was removed from a pager"
	| aInspectorTabName |
	aInspectorTabName := GtInspectorSelectedTabExtractor new 
		inspectorElement: self;
		extract.
	aGtPager context inspectorTabSelector recentlySelectedTab: aInspectorTabName on: self object.
]

{ #category : #'private - event handling' }
GtInspector >> onUpdateWish: anEvent [
	anEvent consumed: true.
	self updateElement.
]

{ #category : #'private - accessing' }
GtInspector >> playgroundElement [
	<return: #GtInspectorObjectElement>
	^ playgroundElement
]

{ #category : #accessing }
GtInspector >> playgroundPageStrategy: aPlaygroundPageStrategy [
	playgroundPageStrategy := aPlaygroundPageStrategy.
	
	self updatePlaygroundPageStrategy.
]

{ #category : #'private - accessing' }
GtInspector >> titleNotifier [
	<return: #GtPhlowTitleNotifier>
	^ titleNotifier
]

{ #category : #'private - updating' }
GtInspector >> updateElement [
	self contentElement updateView.
	self playgroundElement updatePlayPage.
]

{ #category : #'private - hooks' }
GtInspector >> updateExternalSnippetContext [
	externalSnippetContext ifNotNil: [ :aContext |
		externalSnippetContext externalSnippetContext: aContext ]
]

{ #category : #'private - hooks' }
GtInspector >> updatePlaygroundDatabasesRegistry [
	databasesRegistry ifNotNil: [ :aRegistry |
		playgroundElement databasesRegistry: aRegistry ]
]

{ #category : #'private - hooks' }
GtInspector >> updatePlaygroundPageStrategy [
	playgroundPageStrategy ifNotNil: [ :aPlaygroundPageStrategy |
		playgroundElement playgroundPageStrategy: aPlaygroundPageStrategy ]
]

{ #category : #'private - updating' }
GtInspector >> updateTabLabel [
	self titleNotifier notifyIfFocused
]
