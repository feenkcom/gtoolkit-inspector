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
		'titleNotifier'
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

{ #category : #'api - instance creation' }
GtInspector class >> forObject: anObject [
	^ self new object: anObject
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
	^ (#gtView gtPragmas gtItemsFor: aView)
		title: 'Extensions';
		priority: 34
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

{ #category : #initialization }
GtInspector >> initialize [
	super initialize.
	self initializeTitleNotifier.
	self initializeContentElement.
	self initializePlaygroundElement.
	self layout: BlLinearLayout vertical.
	self addChild: self contentElement as: #content.
	self addChild: self playgroundElement as: #playground.
	self addAptitude: (BrLayoutResizerAptitude inherit).
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

{ #category : #'private - updating' }
GtInspector >> updateTabLabel [
	self titleNotifier notifyIfFocused
]
