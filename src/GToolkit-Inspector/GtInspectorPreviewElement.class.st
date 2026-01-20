"
I preview {{gtMethod: GtInspectorPreviewElement >> #previewedElement | label=element }}. 
Users can click inside of the preview and open a context menu, exploring element hierarchy.
"
Class {
	#name : #GtInspectorPreviewElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'previewedElement'
	],
	#category : #'GToolkit-Inspector-Extensions Support'
}

{ #category : #'private - updating' }
GtInspectorPreviewElement >> addMenuItemsForParent: aParentElement of: aPickedElement position: aPositionInPreviewedSpace in: aMenuItems [
	| aLabel aSubMenuItems anElementGroup |
	aLabel := aParentElement == aPickedElement
			ifTrue: [ 'Inspect element' ]
			ifFalse: [ 'Inspect parent' ].
	aMenuItems
		addItem: (BrMenuSubmenuItem new
				label: aLabel preview: aParentElement gtDisplayString;
				submenu: (aSubMenuItems := BrMenuItems new);
				action: [ :anElement | anElement phlow spawnObject: aParentElement ];
				hideOnClick: true).
	anElementGroup := BrMenuItemGroupConfiguration new
			name: #Element;
			priority: 40.

	aParentElement == aPickedElement
		ifTrue: [ aSubMenuItems
				addItem: (BrMenuActionItem new
						icon: BrGlamorousVectorIcons clipboard
							label: 'Copy picked position in previewed space'
							preview: [ self displayedPoint: aPositionInPreviewedSpace ];
						action: [ :aButton | Clipboard default clipboardText: aPositionInPreviewedSpace asString ];
						group: anElementGroup) ].

	aSubMenuItems
		addItem: (BrMenuActionItem new
				icon: BrGlamorousVectorIcons clipboard
					label: 'Copy picked local position'
					preview: [ self
							displayedPoint: (aParentElement globalPointToLocal: aPositionInPreviewedSpace) ];
				action: [ :aButton | 
					Clipboard default
						clipboardText: (aParentElement globalPointToLocal: aPositionInPreviewedSpace) asString ];
				group: anElementGroup).

	aSubMenuItems
			addItem: (BrMenuActionItem new
					icon: BrGlamorousVectorIcons clipboard
						label: 'Copy element class name'
						preview: [ aParentElement className asString ];
					action: [ :aButton | Clipboard default clipboardText: aParentElement className asString ];
					group: anElementGroup).
				
	aParentElement id = BlElementId noId
		ifFalse: [ aSubMenuItems
				addItem: (BrMenuActionItem new
						icon: BrGlamorousVectorIcons clipboard
							label: 'Copy element id'
							preview: [ aParentElement id asSymbol ];
						action: [ :aButton | Clipboard default clipboardText: aParentElement id asBlocElementCode asString ];
						group: anElementGroup).
			aSubMenuItems
				addItem: (BrMenuActionItem new
						icon: BrGlamorousVectorIcons inspect
							label: 'Inspect element id'
							preview: [ aParentElement id asSymbol ];
						action: [ :aButton | aButton phlow spawnObject: aParentElement id ];
						group: anElementGroup) ].

	(GtInspectorElementOverview overviewPropertiesForElement: aParentElement)
		do: [ :eachProperty | 
			aSubMenuItems
				addItem: (BrMenuActionItem new
						icon: BrGlamorousVectorIcons inspect label: eachProperty label;
						action: [ :aButton | eachProperty spawnActionBlock cull: self ];
						group: (BrMenuItemGroupConfiguration new
								name: #Properties;
								priority: 60)) ].

	aParentElement children
		do: [ :eachChild | 
			aSubMenuItems
				addItem: (BrMenuActionItem new
						icon: BrGlamorousVectorIcons inspect
							label: 'Inspect child'
							preview: eachChild gtDisplayString;
						action: [ :anElement | anElement phlow spawnObject: eachChild ];
						group: (BrMenuItemGroupConfiguration new
								name: #Children;
								priority: 70)) ]
]

{ #category : #'private - event handling' }
GtInspectorPreviewElement >> createContextMenuWithContext: aContext [
	| aMenuItems aPositionInPreviewedSpace aPickedElement |
	self previewedElement ifNil: [ ^ nil ].

	aPickedElement := self pickedElementInPreviewedSpace: aContext positionInSpace.
	aPickedElement ifNil: [ ^ nil ].
	aPositionInPreviewedSpace := self
			positionInPreviewedSpace: aContext positionInSpace.

	aMenuItems := BrMenuItems new.

	aPickedElement
		withAllParentsDo: [ :eachElement | 
			self
				addMenuItemsForParent: eachElement
				of: aPickedElement
				position: aPositionInPreviewedSpace
				in: aMenuItems ].

	^ BrMenuExplicitHandle new menu: aMenuItems
]

{ #category : #'private - event handling' }
GtInspectorPreviewElement >> displayedPoint: aPoint [
	^ String
		streamContents: [ :aStream | 
			aPoint x printOn: aStream showingDecimalPlaces: 2.
			aStream nextPut: $@.
			aPoint y printOn: aStream showingDecimalPlaces: 2 ]
]

{ #category : #initialization }
GtInspectorPreviewElement >> initialize [
	super initialize.

	self
		id: #'element-preview--content';
		matchParent.

	self when: BlClickEvent do: [ :anEvent | self onClickEvent: anEvent ].

	self
		addAptitude: (BrGlamorousWithExplicitContextMenuAptitude new
				withCenteredHandle;
				stencil: [ :aContext | self createContextMenuWithContext: aContext ])
]

{ #category : #'private - event handling' }
GtInspectorPreviewElement >> onClickEvent: anEvent [
	| aPickedElement |
	anEvent consumed: true.

	aPickedElement := self pickedElementInPreviewedSpace: anEvent position.
	anEvent currentTarget phlow spawnObject: aPickedElement
]

{ #category : #'private - event handling' }
GtInspectorPreviewElement >> onPreviewedElementChanged [
	self updateElement
]

{ #category : #'private - event handling' }
GtInspectorPreviewElement >> pickedElementInPreviewedSpace: aGlobalPosition [
	"I receive a global position in a space of this preview element.
	I return a child element of the previewed element at the given position."

	<return: #BlElement or: nil>
	| aPreviewedSpace aPreviewedSpacePosition |
	aPreviewedSpace := self previewedElement space ifNil: [ ^ nil ].
	aPreviewedSpacePosition := self positionInPreviewedSpace: aGlobalPosition.

	^ aPreviewedSpace mouseProcessor
		processPickingAt: aPreviewedSpacePosition
]

{ #category : #'accessing - computed' }
GtInspectorPreviewElement >> positionInPreviewedSpace: aGlobalPosition [
	"I receive a global position in a space of this preview element.
	I convert it to a global position in a space of the previewed element."
	<return: #Point>

	| aPreviewedElement aPreviewedSpace mySpace |
	aPreviewedElement := self previewedElement ifNil: [ ^ 0@0 ].
	aPreviewedSpace := aPreviewedElement space ifNil: [ ^ 0@0 ].
	mySpace := self space ifNil: [ ^ 0@0 ].

	^ aGlobalPosition - self positionInSpace + aPreviewedElement positionInSpace
]

{ #category : #accessing }
GtInspectorPreviewElement >> previewedElement [
	^ previewedElement
]

{ #category : #accessing }
GtInspectorPreviewElement >> previewedElement: anElement [
	self assert: [ anElement isKindOf: BlElement ].

	previewedElement == anElement ifTrue: [ ^ self ].
	
	previewedElement := anElement.
	
	self onPreviewedElementChanged
]

{ #category : #'private - updating' }
GtInspectorPreviewElement >> updateElement [
	| aPreviewedElement |
	aPreviewedElement := self previewedElement ifNil: [ ^ self ].

	self
		enqueueTask: (BlTaskAction new action: [ self updatePreviewForElement: aPreviewedElement ])
]

{ #category : #'private - updating' }
GtInspectorPreviewElement >> updatePreviewForElement: aPreviewedElement [
	| aScaleFactor aRenderAction shouldForcePulse |
	aScaleFactor := 1.0.
	self spaceDo: [ :aSpace | aScaleFactor := aSpace windowScale ].

	aRenderAction := [ self
			updatePreviewForElement: aPreviewedElement
			withScaleFactor: aScaleFactor ].

	shouldForcePulse := true.
	self previewedElement
		spaceDo: [ :aSpace | 
			aSpace universe
				uiProcessDo: [ :aUIProcess | 
					shouldForcePulse := aUIProcess isSuspended
							or: [ aUIProcess isTerminated or: [ aUIProcess isTerminating ] ] ] ].

	shouldForcePulse
		ifTrue: aRenderAction
		ifFalse: [ self previewedElement enqueueTask: (BlTaskAction new action: aRenderAction) ]
]

{ #category : #'private - updating' }
GtInspectorPreviewElement >> updatePreviewForElement: aPreviewedElement withScaleFactor: aScaleFactor [
	| aCanvas aSnapshot aSpaceExtent |
	aPreviewedElement forceLayout.
	aSpaceExtent := aPreviewedElement extent.

	aCanvas := Bloc preferableSpartaCanvas
			extent: (aSpaceExtent * aScaleFactor) asIntegerPoint.

	aCanvas fill
		path: aCanvas bounds;
		paint: Color white;
		draw.

	aCanvas transform
		by: [ :t | t scaleBy: aScaleFactor ]
		during: [ aPreviewedElement fullDrawOnSpartaCanvas: aCanvas ].

	aSnapshot := aCanvas asForm.

	self
		enqueueTask: (BlTaskAction new
				action: [ self
						size: aSpaceExtent;
						addChild: (aSnapshot asElement
								elevation: (BlRelativeElevation elevation: -1);
								transformDo: [ :t | 
									t topLeftOrigin.
									t scaleBy: 1 / aScaleFactor ]) ])
]
