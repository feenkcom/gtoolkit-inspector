"
I am the main element that represents an Inspector.
"
Class {
	#name : #GtOldInspector,
	#superclass : #BlElement,
	#traits : 'TGtInspectorObjectAccess + TGtPagerWindowOpener',
	#classTraits : 'TGtInspectorObjectAccess classTrait + TGtPagerWindowOpener classTrait',
	#instVars : [
		'extensions'
	],
	#category : #'GToolkit-Inspector-! Core'
}

{ #category : #'gt-extensions' }
GtOldInspector class >> gtActionsFor: aView [
	<gtView>
	<gtClassView>
	^ (#gtAction gtPragmas gtItemsFor: aView)
		title: 'Actions';
		priority: 35
]

{ #category : #'gt-extensions' }
GtOldInspector class >> gtExtensionsFor: aView [
	<gtView>
	<gtClassView>
	^ (#gtView gtPragmas gtItemsFor: aView)
		title: 'Extensions';
		priority: 34
]

{ #category : #accessing }
GtOldInspector class >> inspectorViews [
	<gtExample>
	^ #gtView gtPragmas
]

{ #category : #testing }
GtOldInspector class >> isDeprecated [
	^ true
]

{ #category : #'instance creation' }
GtOldInspector class >> newOn: anObject [
	"create an inspector element on a given object"
	^ self new 
		object: anObject;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].
]

{ #category : #defaults }
GtOldInspector >> defaultExtensions [
	^ GtInspectorExtensions default inspectorInstance: self
]

{ #category : #accessing }
GtOldInspector >> extensions [
	<return: #GtInspectorExtensions>
	^ extensions
]

{ #category : #'gt-extensions' }
GtOldInspector >> gtExtensionsFor: aView [
	<gtView>
	self extensions ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Extensions';
		priority: 4;
		object: [ self extensions ];
		view: #gtExtensionsFor:
]

{ #category : #initialization }
GtOldInspector >> initialize [
	super initialize.
	self initializeObjectHolder.
	self initializeExtensions.
	self initializeWidget.
	self initializeListeners.
]

{ #category : #initialization }
GtOldInspector >> initializeExtensions [
	extensions := self defaultExtensions.
]

{ #category : #initialization }
GtOldInspector >> initializeListeners [
	self when: GtPagerPageAddedEvent do: [ :anEvent | 
		self onAddedToPager: anEvent pager ].
	self when: GtPagerPageRemovedEvent do: [ :anEvent | 
		self onRemovedFromPager: anEvent pager ].
	self when: GtPagerPageMaximizedEvent do: [ :anEvent | 
		self onMaximizedInPager: anEvent pager ].
	self when: GtPagerPageMinimizedEvent do: [ :anEvent | 
		self onMinimizedInPager: anEvent pager ].
]

{ #category : #initialization }
GtOldInspector >> initializeWidget [
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].
	self updateView.
]

{ #category : #'updating ui' }
GtOldInspector >> mayUpdateView [
	self isAttachedToSceneGraph ifFalse: [ ^ self ].
	self updateView.
]

{ #category : #'instance creation' }
GtOldInspector >> newEmbellisherExtension [
	^ self extensions
]

{ #category : #notifying }
GtOldInspector >> notifyAddedToSceneGraph [
	self extensions addedToSceneGraph
]

{ #category : #notifying }
GtOldInspector >> notifyObjectChangedTo: anObject [
	self extensions objectChangedTo: anObject.
]

{ #category : #notifying }
GtOldInspector >> notifyObjectRemoved [
	self extensions objectRemoved
]

{ #category : #notifying }
GtOldInspector >> notifyRemovedFromSceneGraph [
	self extensions removedFromSceneGraph
]

{ #category : #convenience }
GtOldInspector >> object [
	^ self objectHolder object
]

{ #category : #convenience }
GtOldInspector >> object: anObject [
	| anObjectHolder |
	anObjectHolder := GtInspectorObject new object: anObject.
	self objectHolder: anObjectHolder.
]

{ #category : #convenience }
GtOldInspector >> object: anObject viewSelector: aSymbol [
	| anObjectHolder |
	anObjectHolder := GtInspectorObject new object: anObject; viewSelector: aSymbol.
	self objectHolder: anObjectHolder.
]

{ #category : #'hooks - pager' }
GtOldInspector >> onAddedToPager: aGtPager [
	"Inspector was added to a pager"
	self phlow
		firstChildWithCompositeViewDo: [ :aTabGroup | 
			aGtPager context inspectorTabSelector
				selectTabIn: aTabGroup on: self object ].
]

{ #category : #'hooks - children' }
GtOldInspector >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	self notifyAddedToSceneGraph.
]

{ #category : #'hooks - pager' }
GtOldInspector >> onMaximizedInPager: aGtPager [
	"Inspector was maximized in the pager"
	
]

{ #category : #'hooks - pager' }
GtOldInspector >> onMinimizedInPager: aGtPager [
	"Inspector was minimized int the pager"
]

{ #category : #'hooks - object' }
GtOldInspector >> onObjectHolderChanged [
	self updateView.
	self objectHolder notifyObjectChangedIn: self.
]

{ #category : #'hooks - pager' }
GtOldInspector >> onRemovedFromPager: aGtPager [
	"Inspector was removed from a pager"
	| aInspectorTabName |
	aInspectorTabName := GtInspectorSelectedTabExtractor new 
		inspectorElement: self;
		extract.
	aGtPager context inspectorTabSelector recentlySelectedTab: aInspectorTabName on: self object.
]

{ #category : #'hooks - children' }
GtOldInspector >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.
	self notifyRemovedFromSceneGraph.
]

{ #category : #opening }
GtOldInspector >> pagerWindowTitle [
	<return: #String>
	| aName |
	aName := self object gtDisplayString.
	(aName size > 30) ifTrue: [
		aName := (aName first: 30), '...' ].
	^ 'Inspector on ', aName
]

{ #category : #'updating ui' }
GtOldInspector >> updateContentWith: aContentElement [
	"Create and configure an inspector page for a given object and corresponding content element.
	My job is to set up the pager page decorator and configure the neccesary event listeners"

	self 
		removeChildren;
		addChild: aContentElement
]

{ #category : #'updating ui' }
GtOldInspector >> updateView [
	self objectHolder asElementDo: [ :aPageContentElement |
		self updateContentWith: aPageContentElement ]
]
