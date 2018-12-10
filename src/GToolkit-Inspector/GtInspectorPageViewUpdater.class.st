Class {
	#name : #GtInspectorPageViewUpdater,
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
	isSelected ifNotNil: [ aBrTab viewModel selected: isSelected ].
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
	aBrTabGroup enqueueTask: (BlTaskAction new action: [ 
		| aPhlowView |
		aPhlowView := GtPhlowView empty 
			on: self pagerPageModel model 
			perform: self viewMethodDefinition selector.
		aPhlowView ifItHasContent: [
			| anIndex |
			anIndex := self addView: aPhlowView toCompositeView: aBrTabGroup phlow entity.	
			self addView: aPhlowView at: anIndex toTabGroup: aBrTabGroup ] ])
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

{ #category : #private }
GtInspectorPageViewUpdater >> removeTabOfView: aGtPhlowView fromTabGroup: aBrTabGroup [ 
	aBrTabGroup viewModel tabs 
		detect: [ :eachTabModel | eachTabModel widget phlow entity = aGtPhlowView ]
		ifFound: [ :aTabModel | 
			isSelected := aTabModel isSelected.
			aBrTabGroup viewModel removeTab: aTabModel ]
		ifNone: [ self error: 'Trying to remove a tab that does not exist' ].
	
]

{ #category : #private }
GtInspectorPageViewUpdater >> removeView: aGtPhlowView fromCompositeView: aGtPhlowCompositeView [ 
	aGtPhlowCompositeView views 
		remove: aGtPhlowView 
		ifAbsent: [ self error: 'Trying to remove a Phlow view from a compisite view that does not include it' ].
	
]

{ #category : #private }
GtInspectorPageViewUpdater >> removeView: aGtPhlowView inTabGroup: aBrTabGroup [ 
	aBrTabGroup enqueueTask: (BlTaskAction new action: [ 
		self removeView: aGtPhlowView fromCompositeView: aBrTabGroup phlow entity.
		self removeTabOfView: aGtPhlowView fromTabGroup: aBrTabGroup ]).
]

{ #category : #actions }
GtInspectorPageViewUpdater >> update [
	| aTabGroup |
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
	aGtPhlowView ifItHasContent: [
		self removeView: aGtPhlowView inTabGroup: aBrTabGroup.
		self addViewInTabGroup: aBrTabGroup.
	]
]

{ #category : #accessing }
GtInspectorPageViewUpdater >> viewMethodDefinition [
	^ viewMethodDefinition
]

{ #category : #accessing }
GtInspectorPageViewUpdater >> viewMethodDefinition: anObject [
	viewMethodDefinition := anObject
]
