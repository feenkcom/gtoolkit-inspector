"
I am the main element that represents an Inspector.
"
Class {
	#name : #GtInspector,
	#superclass : #BlElement,
	#traits : 'TGtInspectorObjectAccess + TGtPagerWindowOpener',
	#classTraits : 'TGtInspectorObjectAccess classTrait + TGtPagerWindowOpener classTrait',
	#instVars : [
		'extensions'
	],
	#category : #'GToolkit-Inspector-! Core'
}

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

{ #category : #accessing }
GtInspector class >> inspectorViews [
	<gtExample>
	^ #gtView gtPragmas
]

{ #category : #'instance creation' }
GtInspector class >> newOn: anObject [
	"create an inspector element on a given object"
	^ self new 
		object: anObject;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].
]

{ #category : #defaults }
GtInspector >> defaultExtensions [
	^ GtInspectorExtensions default inspectorInstance: self
]

{ #category : #accessing }
GtInspector >> extensions [
	<return: #GtInspectorExtensions>
	^ extensions
]

{ #category : #'gt-extensions' }
GtInspector >> gtExtensionsFor: aView [
	<gtView>
	self extensions ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Extensions';
		priority: 4;
		object: [ self extensions ];
		view: #gtExtensionsFor:
]

{ #category : #initialization }
GtInspector >> initialize [
	super initialize.
	self initializeObjectHolder.
	self initializeExtensions.
	self initializeWidget.
	self initializeListeners.
]

{ #category : #initialization }
GtInspector >> initializeExtensions [
	extensions := self defaultExtensions.
]

{ #category : #initialization }
GtInspector >> initializeListeners [
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
GtInspector >> initializeWidget [
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].
	self updateView.
]

{ #category : #'updating ui' }
GtInspector >> mayUpdateView [
	self isAttachedToSceneGraph ifFalse: [ ^ self ].
	self updateView.
]

{ #category : #'instance creation' }
GtInspector >> newEmbellisherExtension [
	^ self extensions
]

{ #category : #notifying }
GtInspector >> notifyAddedToSceneGraph [
	self extensions addedToSceneGraph
]

{ #category : #notifying }
GtInspector >> notifyObjectChangedTo: anObject [
	self extensions objectChangedTo: anObject.
]

{ #category : #notifying }
GtInspector >> notifyObjectRemoved [
	self extensions objectRemoved
]

{ #category : #notifying }
GtInspector >> notifyRemovedFromSceneGraph [
	self extensions removedFromSceneGraph
]

{ #category : #convenience }
GtInspector >> object [
	^ self objectHolder object
]

{ #category : #convenience }
GtInspector >> object: anObject [
	| anObjectHolder |
	anObjectHolder := GtInspectorObject new object: anObject.
	self objectHolder: anObjectHolder.
]

{ #category : #'hooks - pager' }
GtInspector >> onAddedToPager: aGtPager [
	"Inspector was added to a pager"
	self phlow
		firstChildWithCompositeViewDo: [ :aTabGroup | 
			aGtPager context inspectorTabSelector
				selectTabIn: aTabGroup on: self object ].
]

{ #category : #'hooks - children' }
GtInspector >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	self notifyAddedToSceneGraph.
]

{ #category : #'hooks - pager' }
GtInspector >> onMaximizedInPager: aGtPager [
	"Inspector was maximized in the pager"
	
]

{ #category : #'hooks - pager' }
GtInspector >> onMinimizedInPager: aGtPager [
	"Inspector was minimized int the pager"
]

{ #category : #'hooks - object' }
GtInspector >> onObjectHolderChanged [
	self updateView.
	self objectHolder notifyObjectChangedIn: self.
]

{ #category : #'hooks - pager' }
GtInspector >> onRemovedFromPager: aGtPager [
	"Inspector was removed from a pager"
	| aInspectorTabName |
	aInspectorTabName := GtInspectorSelectedTabExtractor new 
		inspectorElement: self;
		extract.
	aGtPager context inspectorTabSelector recentlySelectedTab: aInspectorTabName on: self object.
]

{ #category : #'hooks - children' }
GtInspector >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.
	self notifyRemovedFromSceneGraph.
]

{ #category : #opening }
GtInspector >> pagerWindowTitle [
	<return: #String>
	| aName |
	aName := self object gtDisplayString.
	(aName size > 30) ifTrue: [
		aName := (aName first: 30), '...' ].
	^ 'Inspector on ', aName
]

{ #category : #'updating ui' }
GtInspector >> updateContentWith: aContentElement [
	"Create and configure an inspector page for a given object and corresponding content element.
	My job is to set up the pager page decorator and configure the neccesary event listeners"

	self 
		removeChildren;
		addChild: aContentElement
]

{ #category : #'updating ui' }
GtInspector >> updateView [
	self objectHolder asElementDo: [ :aPageContentElement |
		self updateContentWith: aPageContentElement ]
]
