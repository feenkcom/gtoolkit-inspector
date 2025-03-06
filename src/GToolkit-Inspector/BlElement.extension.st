Extension { #name : #BlElement }

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtChildrenFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Children';
		priority: 35;
		expandUpTo: 2;
		items: [ {self} ];
		children: #children;
		column: 'Preview'
			do: [ :aColumn | aColumn
				stencil: [ :eachElement | 
					self gtPreviewThumbnailFor: eachElement ] ];
		column: 'Type' text: [ :eachElement | eachElement class ];
		column: 'Element' text: [ :anElement | (anElement containerName ifNil: [''] ifNotNil: [ :aContainerName | '#',aContainerName, ' ' ]), anElement asString ];
		column: 'Composition layer'
			text: [ :eachElement | 
				eachElement wantsSeparateCompositingLayer
					ifTrue: [ 'Yes' ]
					ifFalse: [ '' ] ]
			width: 100
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtCreateViewSourceFor: aGtViewCreator [
	<gtViewCreator>
	aGtViewCreator
		title: 'explicit';
		source: (String
				streamContents: [ :stream | 
					stream << aGtViewCreator newSelector << ' aView' << String lf << '	<gtView>'
						<< String lf.
					aGtViewCreator variable
						ifNotNil: [ :v | stream << '	' << v << ' ifNil: [ ^aView empty ].' << String lf ].
					stream
						<< '	^ aView explicit
		title: ''' << aGtViewCreator title capitalized
						<< ''';
		stencil: [' << aGtViewCreator objectSource << ']' ])
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtInspectorPaintModelAptitudeIn: aMondrianView [
	| nodes |

	nodes := { self }.
	self viewModelDo: [ :aViewModel | nodes := nodes, aViewModel withAllChildren ].
	self aptitudeDo: [ :aLook | nodes := nodes, aLook withAllChildren ].
	nodes := nodes asSet asArray.
	
	aMondrianView nodes
		stencil: [ :each |
			BrHorizontalPane new
				fitContent;
				alignCenter;
				padding: (BlInsets right: 5);
				addChild: (BrHorizontalPane new 
					background: Color veryLightGray;
					geometry: BlCircleGeometry new;
					padding: (BlInsets all: 5);
					margin: (BlInsets right: 5);
					fitContent;
					addChild: (BrLabel new
						aptitude: (BrGlamorousLabelAptitude new fontSize: 10);
						text: (((each isKindOf: BlElement)
							ifTrue: [ 'W' ]
							ifFalse: [ (each isKindOf: BrAptitude)
								ifTrue: [ 'A' ]
								ifFalse: [ 'M' ] ]))));
				addChild: (BrLabel new
					aptitude: (BrGlamorousLabelAptitude new);
					text: each class name )
				 ];
		with: nodes.
	
	aMondrianView edges 
		stencil: [ :x | 
			"BlSigmoidElement new 
				beHorizontal;"
			BlLineElement new
				border: (BlBorder paint: (Color gray alpha: 0.5))];
		fromRightCenter;
		toLeftCenter;
		connectToAll: #actors.
	
	aMondrianView layout horizontalTree nodeDistance: 20
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		priority: 0;
		stencil: [ 
			GtInspectorElementLiveViewContainer new 
				element: self;
				clipChildren: false  ].
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtOpenInSpaceFor: anAction [
	<gtAction>
	self hasParent ifTrue: [ ^ anAction noAction].
	^ anAction explicit stencil: [
		BrButton new
			aptitude: BrGlamorousButtonWithIconAptitude; 
			action:  [ self hasParent ifFalse: [ BlSpace new rootDo:[:r| r addChild: self];show ]];
			icon: BrGlamorousVectorIcons play;
			label: 'Open in Space' translated ]
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtOverviewFor: aView [
	<gtView>

	^ aView explicit
		title: 'Overview';
		priority: 1;
		stencil: [ GtInspectorElementOverview new
			margin: (BlInsets all: 5);	
			element: self ];
		actionUpdateButton
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtParentsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Parents';
		priority: 36;
		items: [ self withAllParents ];
		column: 'Index' text: [ :_ :anIndex | anIndex ] width: 40;
		column: 'Preview'
			do: [ :aColumn | 
			aColumn
				width: 100;
				stencil: [ :eachElement | 
					| form |
					form := eachElement asSpartaForm.
					BrButton new
						margin: (BlInsets all: 10);
						icon:
							(BlElement new
								size: 50 @ 20;
								"margin: (BlInsets top: 2 bottom: 2);"
									addChild: form asElement asScalableElement);
						label: 'Slides';
						aptitude:
							BrGlamorousButtonWithIconAptitude - BrGlamorousButtonWithLabelTooltipAptitude
								+
									(BrGlamorousWithExplicitDropdownAptitude
										handle: [ BrButton new
												aptitude:
													BrGlamorousButtonWithIconAptitude - BrGlamorousButtonWithLabelTooltipAptitude
														- BrGlamorousButtonExteriorAptitude;
												icon:
													(BlElement new
														size: 50 @ 20;
														"margin: (BlInsets top: 2 bottom: 2);"
															addChild: form asElement asScalableElement) ]
										content: [ form asElement ]);
						constraintsDo: [ :c | "padding: (BlInsets all: 10) " c linear horizontal alignRight ] ] ];
		column: 'Type' text: [ :eachElement | eachElement class ];
		column: 'Element' text: [ :anElement | (anElement containerName ifNil: [''] ifNotNil: [ :aContainerName | '#',aContainerName, ' ' ]), anElement asString ];
		column: 'Clip children'
			text: [ :eachElement | eachElement clipChildren asString ]
			width: 100
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtPreviewElement [
	| aPreviewElement aRenderAction |

	aPreviewElement := BlElement new
		id: #'element-preview--content'.
	aPreviewElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	aPreviewElement 
		when: BlClickEvent 
		do: [ :anEvent | 
			self spaceDo: [ :anElementSpace |
				anEvent currentTarget spaceDo: [ :aPreviewSpace | 
					| aLocalPosition aPickedElement |
					anEvent consumed: true.
					aLocalPosition := anElementSpace == aPreviewSpace
						ifTrue: [ anEvent position - (anEvent currentTarget positionInSpace - self positionInSpace) ]
						ifFalse: [ anEvent currentTarget globalPointToLocal: anEvent position ].
					aPickedElement := anElementSpace mouseProcessor processPickingAt: aLocalPosition.
					anEvent currentTarget phlow spawnObject: aPickedElement ] ] ].
					
	aPreviewElement
		addAptitude: (BrGlamorousWithExplicitContextMenuAptitude new 
			withCenteredHandle;
			stencil: [ :aContext | 
				| aHandle hasMenuItems |
				hasMenuItems := false.
				aHandle := BrMenuExplicitHandle new  menu: ( 
					BrMenuItems new
						in: [ :aMenuItems |
							self spaceDo: [ :anElementSpace |
								aContext anchorElement spaceDo: [ :aPreviewSpace | 
									| aLocalPosition aPickedElement |
									aLocalPosition := anElementSpace == aPreviewSpace
										ifTrue: [ aContext positionInSpace - (aContext anchorElement positionInSpace - self positionInSpace) ]
										ifFalse: [ aContext anchorElement globalPointToLocal: aContext positionInSpace ].
									aPickedElement := anElementSpace mouseProcessor processPickingAt: aLocalPosition.
									
									aPickedElement withAllParentsDo: [ :eachElement | 
										| aLabel |
										aLabel := (eachElement == aPickedElement 
											ifTrue: [ 'Inspect element' ] 
											ifFalse: [ 'Inspect parent' ]).
										hasMenuItems := true.
										eachElement hasChildren
											ifFalse: [
												aMenuItems 
													addItemLabel: aLabel
													preview: eachElement gtDisplayString 
													action: [ :anElement | anElement phlow spawnObject: eachElement ] ]
											ifTrue: [  
												aMenuItems addItem: (BrMenuSubmenuItem new
													label: aLabel preview: eachElement gtDisplayString;
													submenu: (BrMenuItems new 
														in: [ :aSubMenuItems | 
															eachElement children do: [ :eachChild | 
																aSubMenuItems
																	addItemLabel: 'Inspect child' 
																	preview: eachChild gtDisplayString 
																	action: [ :anElement | anElement phlow spawnObject: eachChild ] ] ];
														yourself);
													action: [ :anElement | anElement phlow spawnObject: eachElement ];
													hideOnClick: true) ] ] ] ] ];
						yourself).
				hasMenuItems ifTrue: [ aHandle ] ifFalse: [ nil ] ]).
					
	aPreviewElement enqueueTask: (BlTaskAction new action: [
		| aScaleFactor shouldForcePulse |
		
		aScaleFactor := 1.0.
		aPreviewElement spaceDo: [ :aSpace | aScaleFactor := aSpace windowScale ].

		aRenderAction := [
			| aCanvas aSpaceExtent aSnapshot |

			self forceLayout.
			aSpaceExtent := self extent.

			aCanvas := Bloc preferableSpartaCanvas extent:
				(aSpaceExtent  * aScaleFactor) asIntegerPoint.

			aCanvas fill
				path: aCanvas bounds;
				paint: Color white;
				draw.
			
			aCanvas transform
				by: [ :t | t scaleBy: aScaleFactor ]
				during: [ self fullDrawOnSpartaCanvas: aCanvas ].

			aSnapshot := aCanvas asForm.

			aPreviewElement enqueueTask: (BlTaskAction new action: [
				aPreviewElement
					size: aSpaceExtent;
					addChild: (aSnapshot asElement
						elevation: (BlRelativeElevation elevation: -1);
						transformDo: [ :t |
							t topLeftOrigin.
							t scaleBy: 1 / aScaleFactor ]) ]) ].

		shouldForcePulse := true.
		self spaceDo: [ :aSpace | aSpace universe uiProcessDo: [ :aUIProcess |
				shouldForcePulse := aUIProcess isSuspended or: [ aUIProcess isTerminated or: [ aUIProcess isTerminating ] ] ]  ].
		shouldForcePulse
			ifTrue: aRenderAction
			ifFalse: [ self enqueueTask: (BlTaskAction new action: aRenderAction) ]
	]).
	^ aPreviewElement
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtPreviewFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Preview';
		priority: 2;
		actionUpdateButton;
		stencil: [
			| aPreviewElement aLabel aCaptionText anAddedToSceneHandler aRemovedFromSceneHandler |
			aCaptionText := [ 
				'This is a statically rendered preview', 
					(self isAttachedToSceneGraph 
						ifTrue: [ ' (clickable preview)' ]
						ifFalse: [ ' (not clickable preview)' ]) ].
			aLabel := BrLabel new
					alignCenter;
					hMatchParent;
					aptitude: (BrGlamorousLabelAptitude new foreground: Color gray; glamorousRegularSmallSize);
					text: aCaptionText value.
						
			anAddedToSceneHandler := BlEventHandler
				on: BlElementAddedToSceneGraphEvent 
				do: [ :anEvent | aLabel text: aCaptionText value ].
			aRemovedFromSceneHandler := BlEventHandler
				on: BlElementRemovedFromSceneGraphEvent 
				do: [ :anEvent | aLabel text: aCaptionText value ].
			
			aLabel 
				when: BlElementAddedToSceneGraphEvent 
					do: [ :anEvent | 
						anEvent currentTarget text: aCaptionText value.
						self addEventHandler: anAddedToSceneHandler.
						self addEventHandler: aRemovedFromSceneHandler ];
				when: BlElementRemovedFromSceneGraphEvent 
					do: [ :anEvent | 
						self removeEventHandler: anAddedToSceneHandler.
						self removeEventHandler: aRemovedFromSceneHandler ].
			
			aPreviewElement := BrVerticalPane new.
			aPreviewElement
				matchParent;
				background: aPreviewElement theme status neutralBackgroundColor;
				padding: (BlInsets top: 10 left: 10 bottom: 5 right: 10);
				addChild: (BrFrame new
					matchParent;
					background: Color white;
					addAptitude: BrShadowAptitude;
					padding: (BlInsets all: 10);
					margin: (BlInsets top: 5 left: 10 bottom: 5 right: 10);
					addChild: (BlScrollableElement new
						id: #scrollable;
						constraintsDo: [ :c |
							c horizontal matchParent.
							c vertical matchParent ];
						addChild: self gtPreviewElement);
					addAptitude: BrGlamorousWithHorizontalScrollbarAptitude;
					addAptitude: BrGlamorousWithVerticalScrollbarAptitude);
				addChild: aLabel.
			aPreviewElement ]
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtPreviewThumbnailFor: anElement [
	^ BrAsyncWidget new 
		layout: BlFrameLayout new; 
		margin: (BlInsets all: 10);
		size: 50 @ 20;
		stencil: [
			| form |
			form := anElement asSpartaForm.
			BrButton new
				icon: (BlElement new
					size: 50 @ 20;
					addChild: form asElement asScalableElement);
				label: 'Slides';
				aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonWithLabelTooltipAptitude
					+ (BrGlamorousWithExplicitDropdownAptitude
							handle: [ BrButton new
								aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonWithLabelTooltipAptitude
										- BrGlamorousButtonExteriorAptitude;
								icon: (BlElement new
										size: 50 @ 20;
										addChild: form asElement asScalableElement) ]
							content: [ form asElement ]);
				constraintsDo: [ :c | 
					c linear horizontal alignRight ] ]
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtPropertiesFor: aView [
	<gtView>

	^ aView forward
		title: 'Properties';
		priority: 12;
		object: [ self properties ];
		view: #gtPropertiesFor:
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtResizersFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Resizers' translated;
		tooltip: 'Resizers and measurements chain';
		priority: 15;
		items: [ self withAllParents reversed ];
		column: 'Width'
			text: [ :anElement | anElement constraints horizontal resizer ];
		column: 'Height'
			text: [ :anElement | anElement constraints vertical resizer ];
		column: 'Width spec' 
			text: [ :anElement :anIndex | 
				anElement privatePreviousMeasurementSpec
					ifNotNil: #widthSpec ];
		column: 'Height spec' 
			text: [ :anElement :anIndex | 
				anElement privatePreviousMeasurementSpec
					ifNotNil: #heightSpec ];
		column: 'Layout' text: [ :anElement |
			| aText aVisibilityText |
			aText := anElement layout gtDisplayText.
			aVisibilityText := anElement visibility shouldLayout
				ifTrue: [ ' (should layout)' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ]
				ifFalse: [ ' (do not layout)' ].
			aText append: aVisibilityText asRopedText.
			aText ];
		column: 'Element' text: [ :anElement | anElement ];
		contextItemLabel: 'Inspect horizontal resizer' 
			action: [ :aMenuElement :anElement | 
				aMenuElement phlow spawnObject: anElement constraints horizontal resizer ];
		contextItemLabel: 'Inspect vertical resizer' 
			action: [ :aMenuElement :anElement | 
				aMenuElement phlow spawnObject: anElement constraints vertical resizer ];
		contextItemLabel: 'Inspect previous measurement' 
			action: [ :aMenuElement :anElement | 
				aMenuElement phlow spawnObject: anElement privatePreviousMeasurementSpec ];
		contextItemLabel: 'Inspect previous measurement width spec' 
			action: [ :aMenuElement :anElement | 
				aMenuElement phlow spawnObject: (anElement privatePreviousMeasurementSpec
					ifNotNil: #widthSpec) ];
		contextItemLabel: 'Inspect previous measurement height spec' 
			action: [ :aMenuElement :anElement | 
				aMenuElement phlow spawnObject: (anElement privatePreviousMeasurementSpec
					ifNotNil: #heightSpec) ];
		contextItemLabel: 'Inspect visibility' 
			action: [ :aMenuElement :anElement | 
				aMenuElement phlow spawnObject: anElement visibility ];
		contextItemLabel: 'Inspect layout' 
			action: [ :aMenuElement :anElement | 
				aMenuElement phlow spawnObject: anElement layout ]
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtShortcutsFor: aView [

	"	self shortcuts ifEmpty: [ ^ aView empty ]."

	<gtView>
	^ aView columnedList
		  title: 'Shortcuts' translated;
		  priority: 11;
		  items: [ 
			  | all |
			  all := OrderedCollection new.
			  self withAllParentsDo: [ :el | 
					  all addAll: ((el shortcuts collect: [ :s | el -> s ]) sorted: [:a :b | a value gtDisplayString < b value gtDisplayString ])].
			  all  ];
		  column: 'Name'
		  text: [ :each | 
			  each value name ifNil: [ each value gtDisplayString ] ];
		  column: 'Combination'
		  text: [ :each | each value combination gtDisplayString ];
		  column: 'Element' icon: [ :each | 
			  each key = self
				  ifTrue: [ BlElement new size: 1@1 ]
				  ifFalse: [ 
					  BrButton new
						  beSmallSize;
						  label: each key gtDisplayString;
						  aptitude: (BrGlamorousButtonLabelAptitude new
								   hoveredColor: Color black;
								   pressedColor: Color black)
							  + (BrGlamorousButtonRectangularAptitude
									   paddingScale: 0.8
									   heightScale: 0.85
									   cornerRadius: 3) + (BrStyleCommonAptitude new
								   default: [ :s | s background: (Color gray alpha: 0.1) ];
								   hovered: [ :s | s background: (Color gray alpha: 0.2) ];
								   pressed: [ :s | s background: (Color gray alpha: 0.3) ]);
						  action: [ :aButtonElement | 
						  aButtonElement phlow spawnObject: each key ] ] ]
		  width: 200;
		  send: [ :each | each value ];
		  actionUpdateButton
	"text: [ :each | each key = self ifTrue: [''] ifFalse: [each key gtDisplayString] ];"
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtStatesFor: aView [
	<gtView>

	^ aView forward
		title: 'States';
		priority: 10;
		object: [ self states ];
		view: #gtStatesFor:
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtStylesFor: aView [
	<gtView>

	^ aView forward
		title: 'Styles';
		priority: 10;
		object: [ self styles ];
		view: #gtStylesFor:
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtUserDataFor: aView [

	<gtView>
	^ (self userData gtItemsFor: aView)
		  title: 'User data';
		  priority: 5;
		  actionUpdateButtonTooltip: 'Update user data'
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtWidgetGraphFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Widget';
		priority: 10;
		painting: [ :view | self gtInspectorPaintModelAptitudeIn: view ]
]
