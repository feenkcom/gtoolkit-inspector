Class {
	#name : #GtInspectorElementOverview,
	#superclass : #BrVerticalPane,
	#instVars : [
		'inspectedElement',
		'properties'
	],
	#category : #'GToolkit-Inspector-Convenience and Utilities'
}

{ #category : #'private - properties' }
GtInspectorElementOverview >> buildBoundsProperties [
	| theProperties |	
	
	theProperties := { 
		('Extent {1})' format: { self printPoint: self elementExtent showingDecimalPlaces: 2 }) -> [ self spawnExtent ].
		('Position in parent {1}' format: { self printPoint: self elementPositionInParent showingDecimalPlaces: 2 }) -> [ self spawnPositionInParent ].
		('Visual bounds:', String cr, '{1}' format: { self printRectangle: self elementVisualBounds showingDecimalPlaces: 2 }) -> [ self spawnVisualBounds ].
		('Bounds in space:', String cr,'{1}' format: { self printRectangle: self elementBoundsInSpace asRectangle showingDecimalPlaces: 2 }) -> [ self spawnBoundsInSpace ].
	}.

	^ self buildSectionContainer
		addChild: (self buildSectionLabelNamed: 'Bounds');
		addChildren: (theProperties collect: [ :each |
			self
				buildPropertyButtonNamed: each key
				spawn: each value ])
]

{ #category : #'private - properties' }
GtInspectorElementOverview >> buildCompositionProperties [
	| theParent theProperties |	
	
	theParent := self elementHasParent
		ifTrue: [ { ('Parent:', String cr, '{1}' format: { self elementParent class }) -> [ self spawnParent ] } ]
		ifFalse: [ {  } ].
	
	theProperties := theParent, { 
		('Children ({1})' format: { self elementChildren size }) -> [ self spawnChildren ].
	}.
		
	^ self buildSectionContainer
		addChild: (self buildSectionLabelNamed: 'Composition');
		addChildren: (theProperties collect: [ :each |
			self
				buildPropertyButtonNamed: each key
				spawn: each value ])
]

{ #category : #'private - properties' }
GtInspectorElementOverview >> buildConstraintsProperties [
	| theProperties |
	
	theProperties := { 
		'Common' -> [ self spawnConstraints ].
		('Horizontal ({1})' format: { self elementHorizontalConstraintsName }) -> [ self spawnHorizontalConstraints ].
		('Vertical ({1})' format: { self elementVerticalConstraintsName }) -> [ self spawnVerticalConstraints ].
	}, ((self elementOtherConstraints associations collect: [ :eachAssoc |
		((eachAssoc key name copyReplaceAll: 'Bl' with: '')
			copyReplaceAll: 'Layout' with: '') -> [ self phlow spawnObject: eachAssoc value ]
	]) sorted: [ :a :b | a key < b key  ]).
	
	
	^ self buildSectionContainer
		addChild: (self buildSectionLabelNamed: 'Constraints');
		addChildren: (theProperties collect: [ :each |
			self
				buildPropertyButtonNamed: each key
				spawn: each value ])
]

{ #category : #'private - properties' }
GtInspectorElementOverview >> buildEventProperties [
	| theProperties |	
	
	theProperties := { 
		('Dispatcher ({1})' format: { self elementEventDispatcher type }) -> [ self spawnEventDispatcher ].
		('Handlers ({1})' format: { self elementEventHandlers size }) -> [ self spawnEventHandlers ].
		('Filters ({1})' format: { self elementEventFilters size }) -> [ self spawnEventFilters ].
		('Shortcuts ({1})' format: { self elementShortcuts size }) -> [ self spawnShortcuts ].
	}.
		
	^ self buildSectionContainer
		addChild: (self buildSectionLabelNamed: 'Events');
		addChildren: (theProperties collect: [ :each |
			self
				buildPropertyButtonNamed: each key
				spawn: each value ])
]

{ #category : #'private - properties' }
GtInspectorElementOverview >> buildLayoutProperties [
	| theProperties |
	
	theProperties := { 
		('Layout ({1})' format: { self elementLayoutName }) -> [ self spawnLayout ].
		('Margin (top: {1} right: {2} bottom: {3} left: {4})' format: {
			self elementMargin top.
			self elementMargin right.
			self elementMargin bottom.
			self elementMargin left }) -> [ self spawnMargin ].
		('Padding (top: {1} right: {2} bottom: {3} left: {4})' format: {
			self elementPadding top.
			self elementPadding right.
			self elementPadding bottom.
			self elementPadding left }) -> [ self spawnPadding ].
	} sorted: [ :a :b | a key < b key ].
	
	^ self buildSectionContainer
		addChild: (self buildSectionLabelNamed: 'Layout');
		addChildren: (theProperties collect: [ :each |
			self
				buildPropertyButtonNamed: each key
				spawn: each value ])
]

{ #category : #'private - properties' }
GtInspectorElementOverview >> buildOtherProperties [
	| theProperties aContainer extraProperties |
	
	theProperties := { 
		('User data ({1})' format: { self elementUserData size }) -> [ self spawnUserData ].
		('Element ID ({1})' format: { self elementIdName  }) -> [ self spawnElementId ].
		('Space ({1})' format: { self elementSpaceName  }) -> [ self spawnElementSpace ].
	
	} sorted: [ :a :b | a key < b key ].
	
	aContainer := self buildSectionContainer
		addChild: (self buildSectionLabelNamed: 'Other');
		addChildren: (theProperties collect: [ :each |
			self
				buildPropertyButtonNamed: each key
				spawn: each value ]).
				
	"I build element specific properties that are computed dynamically
	searching for methods with #gtInspectorElementOverview pragma."
	extraProperties := self elementSpecificProperties.
	extraProperties ifEmpty: [ ^ aContainer ].
	aContainer addChildren: (extraProperties collect: [ :each |
			| anElement |
			anElement := self
				buildPropertyButtonNamed: each label
				spawn: each spawnActionBlock.
			each definingMethod ifNotNil: [ :aMethod |
				anElement addAptitude: (GtPhlowBrowseDefinitionAptitude new
					definition: aMethod) ].
			anElement ]).
	
	^ aContainer 
]

{ #category : #'private - instance creation' }
GtInspectorElementOverview >> buildPropertyButtonNamed: aName spawn: aSpawnBlock [
	^ BrHorizontalPane new
		hMatchParent;
		vFitContent;
		alignCenter;
		addAptitude: BrGlamorousLinkButtonExteriorAptitude;
		when: BlClickEvent do: [ :anEvent |
			(GtPhlowUtility isDefinitionRequested: anEvent) ifFalse: [
				anEvent consumed: true.
				aSpawnBlock cull: anEvent currentTarget ] ];
		addChild: (BrEditor new
			hFitContentLimited;
			vFitContent;
			aptitude: BrGlamorousRegularEditorAptitude new glamorousRegularSmallSize;
			padding: BlInsets empty;
			preventMeAndChildrenMouseEvents;
			beReadOnlyWithoutSelection;
			text: aName)
]

{ #category : #'private - instance creation' }
GtInspectorElementOverview >> buildSectionContainer [
	^ BrVerticalPane new
		hMatchParent;
		vFitContent;
		cellSpacing: 5
]

{ #category : #'private - instance creation' }
GtInspectorElementOverview >> buildSectionLabelNamed: aString [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new foreground: Color gray; fontSize: 12);
		hMatchParent;
		text: aString
]

{ #category : #'private - properties' }
GtInspectorElementOverview >> buildStatesProperties [
	| theLocalStates theInheritedStates theProperties |
	
	theLocalStates := (inspectedElement states localStatesCopy asArray collect: [ :eachState |
		('({1} local) {2}' format: { eachState priority . eachState printString }) -> [ self phlow spawnObject: eachState ]
	]) sorted: [ :a :b | a key < b key ].

	theInheritedStates := (inspectedElement states inheritedStatesCopy asArray collect: [ :eachState |
		('({1} inherited) {2}' format: { eachState priority . eachState printString }) -> [ self phlow spawnObject: eachState ]
	]) sorted: [ :a :b | a key < b key ].
	
	theProperties := theLocalStates, theInheritedStates.
	
	^ self buildSectionContainer
		addChild: (self buildSectionLabelNamed: 'States');
		addChildren: (theProperties collect: [ :each |
			self
				buildPropertyButtonNamed: each key
				spawn: each value ])
]

{ #category : #'private - properties' }
GtInspectorElementOverview >> buildVisualProperties [
	| theProperties |
	theProperties := {('Background ({1})' format: {self elementBackgroundName})
				-> [ self spawnBackground ].
			('Border (width: {1})' format: {self elementBorder width})
				-> [ self spawnBorder ].
			('Outskirts ({1})' format: {self elementOutskirtsName})
				-> [ self spawnOutskirts ].
			('Geometry ({1})' format: {self elementGeometryName})
				-> [ self spawnGeometry ].
			('Transformation ({1})' format: {self elementTransformationName})
				-> [ self spawnTransformation ].
			('Visibility ({1})' format: {self elementVisibilityName})
				-> [ self spawnVisibility ].
			('Clip children ({1})' format: {self elementClipChildrenName})
				-> [ self spawnClipChildren ].
			('Focusability ({1})' format: {self elementFocusabilityName})
				-> [ self spawnFocusability ].
			('Focus ({1})' format: {self elementFocusName})
				-> [ self spawnFocus ].
			('Elevation ({1})' format: {self elementElevationName})
				-> [ self spawnElevation ].
			('Effect ({1})' format: {self elementEffectName})
				-> [ self spawnEffect ].
			('Compositing mode ({1})' format: {self elementCompositingModeName})
				-> [ self spawnCompositingMode ]}.

	^ self buildSectionContainer
		addChild: (self buildSectionLabelNamed: 'Visual');
		addChildren: (theProperties
				collect: [ :each | self buildPropertyButtonNamed: each key spawn: each value ])
]

{ #category : #initialization }
GtInspectorElementOverview >> element: anInspectedElement [
	inspectedElement := anInspectedElement.
	self initializeProperties
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> elementBackground [
	^ inspectedElement background
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> elementBackgroundName [
	^ (self elementBackground class name copyReplaceAll: 'Bl' with: '')
		copyReplaceAll: 'Background' with: ''
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> elementBorder [
	^ inspectedElement border 
]

{ #category : #'element - bounds' }
GtInspectorElementOverview >> elementBoundsInSpace [
	^ inspectedElement bounds inSpace
]

{ #category : #'element - composition' }
GtInspectorElementOverview >> elementChildren [
	^ inspectedElement children
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> elementClipChildren [
	^ inspectedElement clipChildren
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> elementClipChildrenName [
	^ self elementClipChildren
		ifTrue: [ 'yes' ]
		ifFalse: [ 'no' ]
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> elementCompositingMode [
	<return: #BlCompositingMode>
	^ inspectedElement compositingMode
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> elementCompositingModeName [
	| anElementMode wantsElementMode wantsEffect wantsName wantsElement wantsParent wantsElementOrEffect parentName |
	anElementMode := self elementCompositingMode.
	wantsElementMode := anElementMode wantsCompositionLayer.
	wantsEffect := inspectedElement effect wantsCompositionLayer.
	wantsElement := inspectedElement wantsSeparateCompositingLayer.
	wantsElementOrEffect := wantsEffect | wantsElement.
	wantsParent := false.
	inspectedElement
		allParentsDo: [ :eachParent | eachParent compositingMode wantsBufferedLayer ifTrue: [ wantsParent := true ] ].
	wantsParent
		ifTrue: [ parentName := ', parent buffered layer' ]
		ifFalse: [ parentName := ', no parent buffered layer' ].

	wantsName := ''.
	wantsElementMode & wantsEffect
		ifTrue: [ wantsName := 'element and effect want' ].
	wantsElementMode & wantsEffect not ifTrue: [ wantsName := 'element wants' ].
	wantsElementMode not & wantsEffect ifTrue: [ wantsName := 'effect wants' ].
	wantsElementMode not & wantsEffect not ifTrue: [ wantsName := 'no one wants' ].

	^ '{1}, {2}{3}'
		format: {wantsElement ifTrue: [ 'yes' ] ifFalse: [ 'no' ].
				wantsName.
				parentName}
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> elementEffect [
	^ inspectedElement effect
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> elementEffectName [
	^ self elementEffect gtDisplayString
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> elementElevation [
	^ inspectedElement elevation
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> elementElevationName [
	^ self elementElevation gtDisplayString
]

{ #category : #'element - events' }
GtInspectorElementOverview >> elementEventDispatcher [
	^ inspectedElement eventDispatcher
]

{ #category : #'element - events' }
GtInspectorElementOverview >> elementEventFilters [
	^ inspectedElement eventDispatcher filters
]

{ #category : #'element - events' }
GtInspectorElementOverview >> elementEventHandlers [
	^ inspectedElement eventDispatcher handlers
]

{ #category : #'element - bounds' }
GtInspectorElementOverview >> elementExtent [
	^ inspectedElement extent
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> elementFocusName [
	"hasFocus: Return true if the inspected element is focused 
		or contains a focused element.
	isFocused: Returns true if the inspected element is focused.
	
	Note: It is possible that an element has focus but is not focused by itself"

	| isFocused hasFocus |
	hasFocus := self elementHasFocus.
	isFocused := self elementIsFocused.

	hasFocus & isFocused ifTrue: [ ^ 'I am focused' ].
	hasFocus & isFocused not ifTrue: [ ^ 'A child is focused' ].
	hasFocus not & isFocused ifTrue: [ ^ 'has not focus and is focused' ].
	hasFocus not & isFocused not
		ifTrue: [ ^ 'neither I nor the children are focused' ].

	^ '?'
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> elementFocusability [
	^ inspectedElement focusability
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> elementFocusabilityName [
	"hasFocusable: Returns true if the inspected element is focusable 
		or if the inspected element contains a reachable child 
		for which #hasFocusable returns true.
	isFocusable: Return true if the inspected element is able to take focus.
	"

	| isFocusable hasFocusable aDescription |
	hasFocusable := inspectedElement hasFocusable.
	isFocusable := inspectedElement isFocusable.

	self elementVisibility isVisible
		ifFalse: [ aDescription := 'Not visible' ]
		ifTrue: [ 
			hasFocusable & isFocusable 
				ifTrue: [ aDescription := 'I am focusable' ].
			hasFocusable & isFocusable not
				ifTrue: [ aDescription := 'A child is focusable' ].
			hasFocusable not & isFocusable 
				ifTrue: [ aDescription := 'I am focusable' ].
			hasFocusable not & isFocusable not
				ifTrue: [ aDescription := 'Not focusable' ] ].

	^ '{1}, {2}'
		format: {self elementFocusability.
				aDescription ifNil: [ '?' ]}
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> elementGeometry [
	^ inspectedElement geometry 
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> elementGeometryName [
	^ self elementGeometry class name copyReplaceAll: 'Bl' with: ''
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> elementHasFocus [
	^ inspectedElement hasFocus
]

{ #category : #'element - composition' }
GtInspectorElementOverview >> elementHasParent [
	^ inspectedElement hasParent
]

{ #category : #'element - constraints' }
GtInspectorElementOverview >> elementHorizontalConstraintsName [
	^ inspectedElement constraints horizontal resizer printString
]

{ #category : #'element - user data' }
GtInspectorElementOverview >> elementId [
	^ inspectedElement id
]

{ #category : #'element - user data' }
GtInspectorElementOverview >> elementIdName [
	^ self elementId asSymbol
		ifNil: [ 'nil' ]
		ifNotNil: [ :aSymbol | '#' , aSymbol asString ]
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> elementIsFocused [
	^ inspectedElement isFocused
]

{ #category : #'element - layout' }
GtInspectorElementOverview >> elementLayout [
	^ inspectedElement layout
]

{ #category : #'element - layout' }
GtInspectorElementOverview >> elementLayoutName [
	^ (self elementLayout class name copyReplaceAll: 'Bl' with: '')
		copyReplaceAll: 'Layout' with: ''
]

{ #category : #'element - layout' }
GtInspectorElementOverview >> elementMargin [
	^ inspectedElement margin 
]

{ #category : #'element - constraints' }
GtInspectorElementOverview >> elementOtherConstraints [
	^ inspectedElement constraints other
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> elementOutskirts [
	^ inspectedElement outskirts
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> elementOutskirtsName [
	^ self elementOutskirts class name
]

{ #category : #'element - layout' }
GtInspectorElementOverview >> elementPadding [
	^ inspectedElement padding
]

{ #category : #'element - composition' }
GtInspectorElementOverview >> elementParent [
	^ inspectedElement parent
]

{ #category : #'element - bounds' }
GtInspectorElementOverview >> elementPositionInParent [
	^ inspectedElement bounds inParent position
]

{ #category : #'element - shortcuts' }
GtInspectorElementOverview >> elementShortcuts [
	^ BlShortcutRegistry new
		addAll: inspectedElement shortcuts;
		yourself
]

{ #category : #'element - user data' }
GtInspectorElementOverview >> elementSpace [
	^ inspectedElement space
]

{ #category : #'element - user data' }
GtInspectorElementOverview >> elementSpaceName [
	^ self elementSpace printString
]

{ #category : #'private - properties' }
GtInspectorElementOverview >> elementSpecificProperties [
	"Collect element overview properties."

	<return: #Collection of: #GtInspectorElementOverviewProperty>
	| allPragmas allProperties |
	allPragmas := Pragma
			allNamed: #gtInspectorElementOverview
			from: inspectedElement class
			to: BlElement.

	allProperties := allPragmas
		collect: [ :eachPragma | 
			| aProperty |
			aProperty := inspectedElement perform: eachPragma methodSelector.
			aProperty definingMethod: eachPragma method.
			aProperty ]
		thenReject: #isNil.
		
	allProperties sort: [ :a :b | a label < b label ].
	^ allProperties
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> elementTransformation [
	^ inspectedElement transformation
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> elementTransformationName [
	^ self elementTransformation isIdentity
		ifTrue: [ 'Identity' ]
		ifFalse: [
			self elementTransformation isPureTranslation
				ifTrue: [ 'Translation' ]
				ifFalse: [ 'Affine' ] ]
]

{ #category : #'element - user data' }
GtInspectorElementOverview >> elementUserData [
	^ inspectedElement userData
]

{ #category : #'element - constraints' }
GtInspectorElementOverview >> elementVerticalConstraintsName [
	^ inspectedElement constraints vertical resizer printString
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> elementVisibility [
	^ inspectedElement visibility
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> elementVisibilityName [
	^ self elementVisibility isVisible
		ifTrue: [ 'Visible' ]
		ifFalse: [ self elementVisibility isGone
				ifTrue: [ 'Gone' ]
				ifFalse: [ self elementVisibility isHidden
						ifTrue: [ 'Hidden' ]
						ifFalse: [ self elementVisibility printString ] ] ]
]

{ #category : #'element - bounds' }
GtInspectorElementOverview >> elementVisualBounds [
	^ inspectedElement visualBounds
]

{ #category : #initialization }
GtInspectorElementOverview >> initialize [
	super initialize.
	
	self matchParent.

	self addChild: (properties := BlElement new
		layout: (BlGridLayout horizontal columnCount: 2; cellSpacing: 8);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ]) asScrollableElement
]

{ #category : #initialization }
GtInspectorElementOverview >> initializeProperties [
	properties removeChildren.
	
	properties addChild: self buildVisualProperties.
	properties addChild: self buildBoundsProperties.
	properties addChild: self buildLayoutProperties.
	properties addChild: self buildConstraintsProperties.
	properties addChild: self buildEventProperties.
	properties addChild: self buildCompositionProperties.
	properties addChild: self buildStatesProperties.
	properties addChild: self buildOtherProperties.
]

{ #category : #private }
GtInspectorElementOverview >> printPoint: aPoint showingDecimalPlaces: anAmountOfDecimalPlaces [
	^ String streamContents: [ :aStream |
		aStream
			nextPut: $(;
			nextPutAll: (((aPoint x printShowingDecimalPlaces: anAmountOfDecimalPlaces) trimRight: [ :ch | ch = $0 ]) trimRight: [ :ch | ch = $. ]);
			nextPut: $@;
			nextPutAll: (((aPoint y printShowingDecimalPlaces: anAmountOfDecimalPlaces) trimRight: [ :ch | ch = $0 ]) trimRight: [ :ch | ch = $. ]);
			nextPut: $) ]
]

{ #category : #private }
GtInspectorElementOverview >> printRectangle: aRectangle showingDecimalPlaces: anAmountOfDecimalPlaces [
	^ String streamContents: [ :aStream |
		aStream
			nextPut: $(;
			nextPutAll: (self printPoint: aRectangle origin showingDecimalPlaces: anAmountOfDecimalPlaces);
			nextPutAll: ' extent: ';
			nextPutAll: (self printPoint: aRectangle extent showingDecimalPlaces: anAmountOfDecimalPlaces);
			nextPut: $) ]
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> spawnBackground [
	self phlow spawnObject: self elementBackground
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> spawnBorder [
	self phlow spawnObject: self elementBorder
]

{ #category : #'element - bounds' }
GtInspectorElementOverview >> spawnBoundsInSpace [
	self phlow spawnObject: self elementBoundsInSpace
]

{ #category : #'element - composition' }
GtInspectorElementOverview >> spawnChildren [
	self phlow spawnObject: self elementChildren
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> spawnClipChildren [
	self phlow spawnObject: self elementClipChildren
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> spawnCompositingMode [
	self phlow
		spawnObject: (GtInspectorElementCompositingModeOverview new
				inspectedElement: inspectedElement)
]

{ #category : #'element - constraints' }
GtInspectorElementOverview >> spawnConstraints [
	self phlow spawnObject: inspectedElement constraints
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> spawnEffect [
	self phlow spawnObject: self elementEffect
]

{ #category : #'element - user data' }
GtInspectorElementOverview >> spawnElementId [
	self phlow spawnObject: self elementId
]

{ #category : #'element - user data' }
GtInspectorElementOverview >> spawnElementSpace [
	self phlow spawnObject: self elementSpace
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> spawnElevation [
	self phlow spawnObject: self elementElevation
]

{ #category : #'element - events' }
GtInspectorElementOverview >> spawnEventDispatcher [
	self phlow spawnObject: self elementEventDispatcher
]

{ #category : #'element - events' }
GtInspectorElementOverview >> spawnEventFilters [
	self phlow spawnObject: self elementEventFilters
]

{ #category : #'element - events' }
GtInspectorElementOverview >> spawnEventHandlers [
	self phlow spawnObject: self elementEventHandlers
]

{ #category : #'element - bounds' }
GtInspectorElementOverview >> spawnExtent [
	self phlow spawnObject: self elementExtent
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> spawnFocus [
	self phlow spawnObject: (GtInspectorElementFocusabilityAndFocusOverview new 
		inspectedElement: inspectedElement)
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> spawnFocusability [
	self phlow spawnObject: (GtInspectorElementFocusabilityAndFocusOverview new 
		inspectedElement: inspectedElement)
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> spawnGeometry [
	self phlow spawnObject: self elementGeometry
]

{ #category : #'element - constraints' }
GtInspectorElementOverview >> spawnHorizontalConstraints [
	self phlow spawnObject: inspectedElement constraints horizontal
]

{ #category : #'element - layout' }
GtInspectorElementOverview >> spawnLayout [
	self phlow spawnObject: self elementLayout
]

{ #category : #'element - layout' }
GtInspectorElementOverview >> spawnMargin [
	self phlow spawnObject: self elementMargin
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> spawnOutskirts [
	self phlow spawnObject: self elementOutskirts
]

{ #category : #'element - layout' }
GtInspectorElementOverview >> spawnPadding [
	self phlow spawnObject: self elementPadding
]

{ #category : #'element - composition' }
GtInspectorElementOverview >> spawnParent [
	self elementHasParent
		ifFalse: [ ^ self ].
	self phlow spawnObject: self elementParent
]

{ #category : #'element - bounds' }
GtInspectorElementOverview >> spawnPositionInParent [
	self phlow spawnObject: self elementPositionInParent
]

{ #category : #'element - shortcuts' }
GtInspectorElementOverview >> spawnShortcuts [
	self phlow spawnObject: self elementShortcuts
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> spawnTransformation [
	self phlow spawnObject: self elementTransformation
]

{ #category : #'element - user data' }
GtInspectorElementOverview >> spawnUserData [
	self phlow spawnObject: self elementUserData
]

{ #category : #'element - constraints' }
GtInspectorElementOverview >> spawnVerticalConstraints [
	self phlow spawnObject: inspectedElement constraints vertical
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> spawnVisibility [
	self phlow spawnObject: self elementVisibility
]

{ #category : #'element - bounds' }
GtInspectorElementOverview >> spawnVisualBounds [
	self phlow spawnObject: self elementVisualBounds
]
