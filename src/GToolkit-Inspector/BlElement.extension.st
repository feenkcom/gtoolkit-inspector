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
BlElement >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		priority: 0;
		stencil: [ GtInspectorElementLiveViewContainer new 
			element: self ].
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtMeasurementChainFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Measurement' translated;
		priority: 15.1;
		items: [
			| withAllParents |
			withAllParents := (Array streamContents: [ :aStream |
				| currentElement |
				currentElement := self.
				aStream nextPut: currentElement.
				[ currentElement hasParent ] whileTrue: [ 
					currentElement := currentElement parent.
					aStream nextPut: currentElement ] ]) reversed ];
		column: 'Width spec' 
			text: [ :anElement :anIndex | 
				anElement privatePreviousMeasurementSpec
					ifNotNil: #widthSpec ];
		column: 'Height spec' 
			text: [ :anElement :anIndex | 
				anElement privatePreviousMeasurementSpec
					ifNotNil: #heightSpec ];
		column: 'Layout' text: [ :anElement :anIndex | anElement layout ];
		column: 'Element' text: [ :anElement :anIndex | anElement ]
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
									(BrGlamorousWithDropdownAptitude
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
			| aPreviewElement |
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
				addChild: (BrLabel new
					alignCenter;
					hMatchParent;
					aptitude: (BrGlamorousLabelAptitude new foreground: Color gray; glamorousRegularSmallSize);
					text: 'This is a statically rendered preview').
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
					+ (BrGlamorousWithDropdownAptitude
							handle: [ BrButton new
								aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonWithLabelTooltipAptitude
										- BrGlamorousButtonExteriorAptitude;
								icon: (BlElement new
										size: 50 @ 20;
										addChild: form asElement asScalableElement) ]
							content: [ form asElement ]) beNotResizable;
				constraintsDo: [ :c | 
					c linear horizontal alignRight ] ]
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtPropertiesFor: aView [
	<gtView>

	^ aView forward
		title: 'Properties';
		priority: 11;
		object: [ self properties ];
		view: #gtPropertiesFor:
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtResizersFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Resizers' translated;
		priority: 15;
		items: [ self withAllParents reversed ];
		column: 'Width'
			text: [ :anElement | anElement constraints horizontal resizer ];
		column: 'Height'
			text: [ :anElement | anElement constraints vertical resizer ];
		column: 'Layout' text: [ :anElement | anElement layout ];
		column: 'Element' text: [ :anElement | anElement ]
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtShortcutsFor: aView [

	"	self shortcuts ifEmpty: [ ^ aView empty ]."

	<gtView>
	^ aView columnedList
		  title: 'Shortcuts' translated;
		  priority: 10;
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
		  send: [ :each | each value ]
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
