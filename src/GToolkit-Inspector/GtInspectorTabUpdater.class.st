Class {
	#name : #GtInspectorTabUpdater,
	#superclass : #Object,
	#instVars : [
		'inspectorInstance',
		'viewMethodDefinition',
		'isSelected'
	],
	#category : #'GToolkit-Inspector-System Observer'
}

{ #category : #'private - updating' }
GtInspectorTabUpdater >> addView: aPhlowView toCompositeView: aGtPhlowCompositeView [ 
	| aHigherViewIndexOrNil |
	aHigherViewIndexOrNil := aGtPhlowCompositeView views 
		detectIndex: [ :existingView | 
			GtPhlowUtility hasHigherPriority: aPhlowView than: existingView ]
		ifNone: [ nil ].
	aHigherViewIndexOrNil 
		ifNil: [
			aGtPhlowCompositeView views addLast: aPhlowView ]
		ifNotNil: [
			aGtPhlowCompositeView views add: aPhlowView beforeIndex: aHigherViewIndexOrNil ].
]

{ #category : #'private - updating' }
GtInspectorTabUpdater >> addView: aGtPhlowView toTabGroup: aBrTabGroup [
	| anIndex aTabViews |
	aTabViews := aBrTabGroup phlow allChildrenWithView
		collect: [ :eachTab | eachTab phlow entity ].
	anIndex := GtPhlowUtility
		findIndexFor: aGtPhlowView
		in: aTabViews.
	GtPhlowUtility 
		createTabElementFor: aGtPhlowView 
		andDo: [ :aBrTab |
			isSelected ifNotNil: [ 
				isSelected ifTrue: [ aBrTabGroup viewModel deselectAll ].
				aBrTab selected: isSelected ].
			aBrTabGroup addTab: aBrTab at: anIndex. ]
]

{ #category : #'private - updating' }
GtInspectorTabUpdater >> addViewInTabGroup: aBrTabGroup [
	aBrTabGroup enqueueTask: (BlTaskAction new
		action: [ | aPhlowView |
			aPhlowView := GtPhlowView empty
				on: self object
				perform: self selector.
			aPhlowView ifItHasContent: [ 
				self
					addView: aPhlowView
					toCompositeView: aBrTabGroup phlow entity.
				self addView: aPhlowView toTabGroup: aBrTabGroup ] ])
]

{ #category : #'private - accessing' }
GtInspectorTabUpdater >> compositeViewElement [
	<return: #BrTabGroup>
	^ GtPhlowUtility compositeViewElementIn: self inspectorInstance
]

{ #category : #accessing }
GtInspectorTabUpdater >> inspectorInstance [
	^ inspectorInstance
]

{ #category : #accessing }
GtInspectorTabUpdater >> inspectorInstance: anObject [
	inspectorInstance := anObject
]

{ #category : #convenience }
GtInspectorTabUpdater >> object [
	^ self inspectorInstance object
]

{ #category : #updating }
GtInspectorTabUpdater >> remove [
	| aBrTabGroup |
	"Find a composite element"
	aBrTabGroup := self compositeViewElement.
	"Find existing view (that should be updated, if any)"
	aBrTabGroup phlow entity views 
		detect: [ :eachView | eachView definingMethod = self viewMethodDefinition ] 
		ifFound: [ :aGtPhlowView | self removeView: aGtPhlowView inTabGroup: aBrTabGroup ] 
		ifNone: [ "ignore" ]
]

{ #category : #'private - updating' }
GtInspectorTabUpdater >> removeTabOfView: aGtPhlowView fromTabGroup: aBrTabGroup [ 
	aBrTabGroup viewModel tabs 
		detect: [ :eachTabModel | (eachTabModel widget phlow entity = aGtPhlowView)
			or: [ eachTabModel widget phlow entity definingMethod = aGtPhlowView definingMethod ] ]
		ifFound: [ :aTabModel | 
			isSelected := aTabModel isSelected.
			aBrTabGroup viewModel removeTab: aTabModel ]
		ifNone: [ "Trying to remove a tab that does not exist" ].
]

{ #category : #'private - updating' }
GtInspectorTabUpdater >> removeView: anExistingPhlowView fromCompositeView: aGtPhlowCompositeView [ 
	aGtPhlowCompositeView views 
		remove: anExistingPhlowView 
		ifAbsent: [ aGtPhlowCompositeView views 
			detect: [ :eachPhlow | eachPhlow definingMethod = anExistingPhlowView definingMethod ] 
			ifFound: [ :aPhlow | aGtPhlowCompositeView views remove: aPhlow ] 
			ifNone: [ "Trying to remove a Phlow view that does not exist in a composite view" ] ].
]

{ #category : #'private - updating' }
GtInspectorTabUpdater >> removeView: anExistingPhlowView inTabGroup: aBrTabGroup [ 
	aBrTabGroup enqueueTask: (BlTaskAction new action: [ 
		self removeView: anExistingPhlowView fromCompositeView: aBrTabGroup phlow entity.
		self removeTabOfView: anExistingPhlowView fromTabGroup: aBrTabGroup ]).
]

{ #category : #convenience }
GtInspectorTabUpdater >> selector [
	^ self viewMethodDefinition selector
]

{ #category : #updating }
GtInspectorTabUpdater >> update [
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

{ #category : #'private - updating' }
GtInspectorTabUpdater >> updateView: anExistingPhlowView inTabGroup: aBrTabGroup [ 
	anExistingPhlowView ifItHasContent: [
		self removeView: anExistingPhlowView inTabGroup: aBrTabGroup.
		self addViewInTabGroup: aBrTabGroup.
	]
]

{ #category : #accessing }
GtInspectorTabUpdater >> viewMethodDefinition [
	^ viewMethodDefinition
]

{ #category : #accessing }
GtInspectorTabUpdater >> viewMethodDefinition: anObject [
	viewMethodDefinition := anObject
]
