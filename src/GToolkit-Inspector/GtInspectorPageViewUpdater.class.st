Class {
	#name : #GtInspectorPageViewUpdater,
	#superclass : #Object,
	#traits : 'TBlDebug + TGtInspectorUtility',
	#classTraits : 'TBlDebug classTrait + TGtInspectorUtility classTrait',
	#instVars : [
		'inspectorWidget',
		'pagerPageModel',
		'viewMethodDefinition'
	],
	#category : #'GToolkit-Inspector-Utility'
}

{ #category : #private }
GtInspectorPageViewUpdater >> addView: aGtPhlowView at: anInteger toTabGroup: aBrTabGroup [ 
	| aBrTab |
	aBrTab := BrTab new.
	self registerShowDefinitionEventOn: aBrTab forView: aGtPhlowView.
	aBrTab phlow
		beView;
		entity: aGtPhlowView.
	aBrTab
		look: BrGlamorousTabLook;
		label: aGtPhlowView title;
		stencil: [ aGtPhlowView asTaskItView
				asElementDo: [ :element | 
					element phlow beViewContent; entity: aGtPhlowView.
					element asScrollableElement ] ];
		actionsStencil: (aGtPhlowView actionsToolbarForElement: aBrTab).
	aBrTabGroup addTab: aBrTab at: anInteger
]

{ #category : #private }
GtInspectorPageViewUpdater >> addView: aPhlowView toCompositeView: aGtPhlowCompositeView [ 
	<return: #Integer>
	"Return a view position in composite view"
	| aHigherViewIndexOrNil |
	aHigherViewIndexOrNil := aGtPhlowCompositeView views 
		detectIndex: [ :existingView | existingView priority > aPhlowView priority ]
		ifNone: [ nil ].
	^ aHigherViewIndexOrNil 
		ifNil: [ 
			aGtPhlowCompositeView views addLast: aPhlowView.
			aGtPhlowCompositeView views size ]
		ifNotNil: [ 
			aGtPhlowCompositeView views add: aPhlowView beforeIndex: aHigherViewIndexOrNil.
			aHigherViewIndexOrNil ].
]

{ #category : #private }
GtInspectorPageViewUpdater >> addViewInTabGroup: aBrTabGroup [ 
	| aPhlowView |
	aPhlowView := GtPhlowView empty on: self pagerPageModel model perform: self viewMethodDefinition selector.
	aPhlowView ifItHasContent: [
		| anIndex |
		anIndex := self addView: aPhlowView toCompositeView: aBrTabGroup phlow entity.
		aBrTabGroup enqueueTask: (BlTaskAction new action:
			[ self addView: aPhlowView at: anIndex toTabGroup: aBrTabGroup ]).
	]
]

{ #category : #private }
GtInspectorPageViewUpdater >> compositeViewElement [
	<return: #BrTabGroup>
	^ self utility compositeViewElementInPagerPageModel: self pagerPageModel
]

{ #category : #accessing }
GtInspectorPageViewUpdater >> inspectorWidget [
	^ inspectorWidget
]

{ #category : #accessing }
GtInspectorPageViewUpdater >> inspectorWidget: anObject [
	inspectorWidget := anObject
]

{ #category : #accessing }
GtInspectorPageViewUpdater >> pagerPageModel [
	^ pagerPageModel
]

{ #category : #accessing }
GtInspectorPageViewUpdater >> pagerPageModel: anObject [
	pagerPageModel := anObject
]

{ #category : #private }
GtInspectorPageViewUpdater >> registerShowDefinitionEventOn: tab forView: view [
	tab
		when: BlMouseDownEvent
		do: [ :event | 
			event modifiers isAlt
				ifTrue: [ event consumed: true.
					tab
						fireEvent:
							(GtPhlowObjectToSpawn new
								object: view definingMethod;
								sourceElement: tab) ] ]
]

{ #category : #actions }
GtInspectorPageViewUpdater >> update [
	| aTabGroup aRing |
	"Find a composite element"
	aTabGroup := self compositeViewElement.
	"Find existing view (that should be updated, if any)"
	aTabGroup phlow entity views 
		detect: [ :eachView | eachView definingMethod = self viewMethodDefinition ] 
		ifFound: [ :aView | self updateView: aView inTabGroup: aTabGroup ] 
		ifNone: [ self addViewInTabGroup: aTabGroup ]
]

{ #category : #private }
GtInspectorPageViewUpdater >> updateView: aGtPhlowView inTabGroup: aBrTabGroup [ 
	self flag: 'TODO: Now it updates whole page'.
	self inspectorWidget enqueueTask: (
		BlTaskAction new action: [ self inspectorWidget 
			updatePageModelWidget: self pagerPageModel ])
]

{ #category : #accessing }
GtInspectorPageViewUpdater >> viewMethodDefinition [
	^ viewMethodDefinition
]

{ #category : #accessing }
GtInspectorPageViewUpdater >> viewMethodDefinition: anObject [
	viewMethodDefinition := anObject
]
