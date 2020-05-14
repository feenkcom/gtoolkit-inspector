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
GtInspectorElementOverview >> buildCompositionProperties [
	| theParent theProperties |	
	
	theParent := self elementHasParent
		ifTrue: [ { ('Parent ({1})' format: { self elementParent }) -> [ self spawnParent ] } ]
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
		('Margin ({1})' format: { self elementMargin }) -> [ self spawnMargin ].
		('Padding ({1})' format: { self elementPadding }) -> [ self spawnPadding ].
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
	| theProperties |
	
	theProperties := { 
		('User data ({1})' format: { self elementUserData size }) -> [ self spawnUserData ].
	} sorted: [ :a :b | a key < b key ].
	
	^ self buildSectionContainer
		addChild: (self buildSectionLabelNamed: 'Other');
		addChildren: (theProperties collect: [ :each |
			self
				buildPropertyButtonNamed: each key
				spawn: each value ])
]

{ #category : #'private - instance creation' }
GtInspectorElementOverview >> buildPropertyButtonNamed: aName spawn: aSpawnBlock [
	^ BrButton new
		beSmall;
		look: (BrGlamorousButtonRectangularLook new + 
			(BrInteractiveCommonLook new
				default: [ :aWidget | aWidget background: BrGlamorousColors neutralBackgroundColor ]) + BrGlamorousButtonLabelLook new);
		label: aName;
		hMatchParent;
		action: aSpawnBlock
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
		look: (BrGlamorousLabelLook new foreground: Color gray; fontSize: 12);
		hMatchParent;
		text: aString
]

{ #category : #'private - properties' }
GtInspectorElementOverview >> buildVisualProperties [
	| theProperties |	
	
	theProperties := { 
		('Background ({1})' format: { self elementBackgroundName }) -> [ self spawnBackground ].
		'Border' -> [ self spawnBorder ].
		('Geometry ({1})' format: { self elementGeometryName }) -> [ self spawnGeometry ].
	}.
		
	^ self buildSectionContainer
		addChild: (self buildSectionLabelNamed: 'Visual');
		addChildren: (theProperties collect: [ :each |
			self
				buildPropertyButtonNamed: each key
				spawn: each value ])
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

{ #category : #'element - composition' }
GtInspectorElementOverview >> elementChildren [
	^ inspectedElement children
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

{ #category : #'element - visual' }
GtInspectorElementOverview >> elementGeometry [
	^ inspectedElement geometry 
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> elementGeometryName [
	^ self elementGeometry class name copyReplaceAll: 'Bl' with: ''
]

{ #category : #'element - composition' }
GtInspectorElementOverview >> elementHasParent [
	^ inspectedElement hasParent
]

{ #category : #'element - constraints' }
GtInspectorElementOverview >> elementHorizontalConstraintsName [
	^ inspectedElement constraints horizontal resizer printString
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

{ #category : #'element - layout' }
GtInspectorElementOverview >> elementPadding [
	^ inspectedElement padding
]

{ #category : #'element - composition' }
GtInspectorElementOverview >> elementParent [
	^ inspectedElement parent
]

{ #category : #'element - shortcuts' }
GtInspectorElementOverview >> elementShortcuts [
	^ inspectedElement shortcuts
]

{ #category : #'element - user data' }
GtInspectorElementOverview >> elementUserData [
	^ inspectedElement userData
]

{ #category : #'element - constraints' }
GtInspectorElementOverview >> elementVerticalConstraintsName [
	^ inspectedElement constraints vertical resizer printString
]

{ #category : #initialization }
GtInspectorElementOverview >> initialize [
	super initialize.
	
	self matchParent.
	
	self addChild: (BrEditor new
		hMatchParent;
		vFitContent;
		look: (BrGlamorousEditorLook new lineSpacing: 6);
		margin: (BlInsets left: 5);
		beReadOnlyWithoutSelection;
		text: ('Want to know more?' asRopedText fontSize: 14; foreground: Color darkGray), String cr asRopedText,
			('Click on items below to inspect my properties:' asRopedText fontSize: 12; foreground: Color gray)).

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
	properties addChild: self buildEventProperties.
	properties addChild: self buildLayoutProperties.
	properties addChild: self buildConstraintsProperties.
	properties addChild: self buildCompositionProperties.
	properties addChild: self buildOtherProperties
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> spawnBackground [
	self phlow spawnObject: self elementBackground
]

{ #category : #'element - visual' }
GtInspectorElementOverview >> spawnBorder [
	self phlow spawnObject: self elementBorder
]

{ #category : #'element - composition' }
GtInspectorElementOverview >> spawnChildren [
	self phlow spawnObject: self elementChildren
]

{ #category : #'element - constraints' }
GtInspectorElementOverview >> spawnConstraints [
	self phlow spawnObject: inspectedElement constraints
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

{ #category : #'element - shortcuts' }
GtInspectorElementOverview >> spawnShortcuts [
	self phlow spawnObject: self elementShortcuts
]

{ #category : #'element - user data' }
GtInspectorElementOverview >> spawnUserData [
	self phlow spawnObject: self elementUserData
]

{ #category : #'element - constraints' }
GtInspectorElementOverview >> spawnVerticalConstraints [
	self phlow spawnObject: inspectedElement constraints vertical
]
