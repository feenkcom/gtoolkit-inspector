Class {
	#name : #GtOldInspectorPageViewUpdater,
	#superclass : #Object,
	#traits : 'TBlDebug + TGtInspectorUtility',
	#classTraits : 'TBlDebug classTrait + TGtInspectorUtility classTrait',
	#instVars : [
		'inspectorWidget',
		'pagerPageModel',
		'viewMethodDefinition',
		'isSelected'
	],
	#category : #'GToolkit-Inspector-Utility'
}

{ #category : #private }
GtOldInspectorPageViewUpdater >> addView: aPhlowView toCompositeView: aGtPhlowCompositeView [ 
	| aHigherViewIndexOrNil |
	aHigherViewIndexOrNil := aGtPhlowCompositeView views 
		detectIndex: [ :existingView | existingView priority > aPhlowView priority ]
		ifNone: [ nil ].
	aHigherViewIndexOrNil 
		ifNil: [ 
			aGtPhlowCompositeView views addLast: aPhlowView ]
		ifNotNil: [ 
			aGtPhlowCompositeView views add: aPhlowView beforeIndex: aHigherViewIndexOrNil ].
]

{ #category : #private }
GtOldInspectorPageViewUpdater >> addView: aGtPhlowView toTabGroup: aBrTabGroup [
	| aBrTab anIndex aTabViews |
	aBrTab := BrTab new.
	aTabViews := aBrTabGroup phlow allChildrenWithView
		collect: [ :eachTab | eachTab phlow entity ].
	anIndex := self utility
		detectPhlowIndex: aGtPhlowView
		byPriorityIn: aTabViews.
	self registerShowDefinitionEventOn: aBrTab forView: aGtPhlowView.
	aBrTab phlow
		beView;
		entity: aGtPhlowView.
	aBrTab
		look: BrGlamorousTabLook;
		label: aGtPhlowView title;
		stencil: [ 
			| aTaskItView |
			aTaskItView := aGtPhlowView asTaskItView.
			aTaskItView asElementDo: [ :element | 
					element phlow
						beViewContent;
						entity: aTaskItView.
					element asScrollableElement ] ];
		toolbarStencil: [ aGtPhlowView actionsToolbarForElement: aBrTab ].
	isSelected ifNotNil: [ aBrTab selected: isSelected ].
	aBrTabGroup addTab: aBrTab at: anIndex
]

{ #category : #private }
GtOldInspectorPageViewUpdater >> addViewInTabGroup: aBrTabGroup [
	aBrTabGroup
		enqueueTask:
			(BlTaskAction new
				action: [ | aPhlowView |
					aPhlowView := GtPhlowView empty
						on: self pagerPageModel model
						perform: self viewMethodDefinition selector.
					aPhlowView
						ifItHasContent: [ 
							self
								addView: aPhlowView
								toCompositeView: aBrTabGroup phlow entity.
							self addView: aPhlowView toTabGroup: aBrTabGroup ] ])
]

{ #category : #private }
GtOldInspectorPageViewUpdater >> compositeViewElement [
	<return: #BrTabGroup>
	^ self utility compositeViewElementInPagerPageModel: self pagerPageModel
]

{ #category : #accessing }
GtOldInspectorPageViewUpdater >> inspectorWidget [
	^ inspectorWidget
]

{ #category : #accessing }
GtOldInspectorPageViewUpdater >> inspectorWidget: anObject [
	inspectorWidget := anObject
]

{ #category : #accessing }
GtOldInspectorPageViewUpdater >> pagerPageModel [
	^ pagerPageModel
]

{ #category : #accessing }
GtOldInspectorPageViewUpdater >> pagerPageModel: anObject [
	pagerPageModel := anObject
]

{ #category : #private }
GtOldInspectorPageViewUpdater >> registerShowDefinitionEventOn: tab forView: view [
	tab
		when: BlMouseDownEvent
		do: [ :event | 
			event modifiers isAlt
				ifTrue: [ event consumed: true.
					tab
						fireEvent:
							(GtPhlowObjectToSpawn new
								object: view allDefiningMethods;
								sourceElement: tab) ] ]
]

{ #category : #actions }
GtOldInspectorPageViewUpdater >> remove [
	| aBrTabGroup |
	"Find a composite element"
	aBrTabGroup := self compositeViewElement.
	"Find existing view (that should be updated, if any)"
	aBrTabGroup phlow entity views 
		detect: [ :eachView | eachView definingMethod = self viewMethodDefinition ] 
		ifFound: [ :aGtPhlowView | self removeView: aGtPhlowView inTabGroup: aBrTabGroup ] 
		ifNone: [ "ignore" ]
]

{ #category : #private }
GtOldInspectorPageViewUpdater >> removeTabOfView: aGtPhlowView fromTabGroup: aBrTabGroup [ 
	aBrTabGroup viewModel tabs 
		detect: [ :eachTabModel | (eachTabModel widget phlow entity = aGtPhlowView)
			or: [ eachTabModel widget phlow entity definingMethod = aGtPhlowView definingMethod ] ]
		ifFound: [ :aTabModel | 
			isSelected := aTabModel isSelected.
			aBrTabGroup viewModel removeTab: aTabModel ]
		ifNone: [ self flag: 'Trying to remove a tab that does not exist' ].
]

{ #category : #private }
GtOldInspectorPageViewUpdater >> removeView: aGtPhlowView fromCompositeView: aGtPhlowCompositeView [ 
	aGtPhlowCompositeView views 
		remove: aGtPhlowView 
		ifAbsent: [ aGtPhlowCompositeView views 
			detect: [ :eachPhlow | eachPhlow definingMethod = aGtPhlowView definingMethod ] 
			ifFound: [ :aPhlow | aGtPhlowCompositeView views remove: aPhlow ] 
			ifNone: [ self error: 'Trying to remove a Phlow view that does not exist in a composite view' ] ].
	
]

{ #category : #private }
GtOldInspectorPageViewUpdater >> removeView: aGtPhlowView inTabGroup: aBrTabGroup [ 
	aBrTabGroup enqueueTask: (BlTaskAction new action: [ 
		self removeView: aGtPhlowView fromCompositeView: aBrTabGroup phlow entity.
		self removeTabOfView: aGtPhlowView fromTabGroup: aBrTabGroup ]).
]

{ #category : #actions }
GtOldInspectorPageViewUpdater >> update [
	| aTabGroup |
	"Find a composite element"
	aTabGroup := self compositeViewElement.
	aTabGroup ifNil: [ ^ self ].
	"Find existing view (that should be updated, if any)"
	aTabGroup phlow entity views 
		detect: [ :eachView | eachView definingMethod = self viewMethodDefinition ] 
		ifFound: [ :aView | self updateView: aView inTabGroup: aTabGroup ] 
		ifNone: [ self addViewInTabGroup: aTabGroup ] 
]

{ #category : #private }
GtOldInspectorPageViewUpdater >> updateView: aGtPhlowView inTabGroup: aBrTabGroup [ 
	aGtPhlowView ifItHasContent: [
		self removeView: aGtPhlowView inTabGroup: aBrTabGroup.
		self addViewInTabGroup: aBrTabGroup.
	]
]

{ #category : #accessing }
GtOldInspectorPageViewUpdater >> viewMethodDefinition [
	^ viewMethodDefinition
]

{ #category : #accessing }
GtOldInspectorPageViewUpdater >> viewMethodDefinition: anObject [
	viewMethodDefinition := anObject
]
