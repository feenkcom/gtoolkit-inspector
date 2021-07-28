"
I display an embedded playground.

{{gtExample:GtInspectorExamples>>#playgroundElement|previewExpanded}}


"
Class {
	#name : #GtInspectorPlaygroundElement,
	#superclass : #GtInspectorObjectElement,
	#instVars : [
		'playPage',
		'playPageElement',
		'resizerElement',
		'widthStrategy'
	],
	#category : 'GToolkit-Inspector-UI'
}

{ #category : #'private - visibility' }
GtInspectorPlaygroundElement >> beExact: aNumber [
	widthStrategy := BrResizerElementLength exact: aNumber.
]

{ #category : #'api - visibility' }
GtInspectorPlaygroundElement >> collapse [
	self height: self minimumHeight.
]

{ #category : #defaults }
GtInspectorPlaygroundElement >> defaultPlayPage [
	^ GtPlayPage newDefault.
]

{ #category : #'api - visibility' }
GtInspectorPlaygroundElement >> expand [
	widthStrategy adjustHeightFor: self.
]

{ #category : #initialization }
GtInspectorPlaygroundElement >> initialize [
	super initialize.
	playPage := self defaultPlayPage.
	widthStrategy := BrResizerElementLength exact: self minimumHeight.
	self initializePlayPageElement.
	self layout: (BlLinearLayout vertical cellSpacing: 5).
	self
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ].

	"resizer is added in this method"
	self initializeResizerElement.
	self background: self theme status neutralBackgroundColor.
	self addChild: self playPageElement as: #playPage.
	self
		addAptitude:
			(BrLayoutResizerAptitude new
				hInherit: self;
				hInherit: self playPageElement).
	self updatePlayPage
]

{ #category : #initialization }
GtInspectorPlaygroundElement >> initializePlayPageElement [
	playPageElement := self playPage asElement.
	playPageElement 
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	self playPage bindingsDo: [ :eachBinding | 
		eachBinding at: #thisPlayground put: playPageElement ].
	
]

{ #category : #initialization }
GtInspectorPlaygroundElement >> initializeResizerElement [
	self
		addAptitude: (BrGlamorousWithVerticalResizerAptitude new beTop
		resizerDo: [ :theResizer | resizerElement := theResizer ]).
	self resizerElement
		when: BlResizerResizedEvent
			do: [ :anEvent | self onResizerResized: anEvent ];
		when: BlDoubleClickEvent
			do: [ :anEvent | self onResizerDoubleClick: anEvent ]
]

{ #category : #'private - testing' }
GtInspectorPlaygroundElement >> isCollapsed [
	<return: #Boolean>
	^ self height <= self minimumHeight
]

{ #category : #'private - accessing' }
GtInspectorPlaygroundElement >> minimumHeight [
	^ 5
]

{ #category : #'private - hooks' }
GtInspectorPlaygroundElement >> onObjectHolderChanged [
	super onObjectHolderChanged.
	self updatePlayPage.
]

{ #category : #'private - event handling' }
GtInspectorPlaygroundElement >> onResizerDoubleClick: anEvent [
	anEvent consumed: true.
	self isCollapsed
		ifTrue: [ self expand ]
		ifFalse: [ self collapse ]
]

{ #category : #'private - event handling' }
GtInspectorPlaygroundElement >> onResizerResized: anEvent [
	self beExact: anEvent extent y
]

{ #category : #'private - accessing' }
GtInspectorPlaygroundElement >> playPage [
	<return: #GtPlayPage>
	^ playPage
]

{ #category : #'private - accessing' }
GtInspectorPlaygroundElement >> playPageElement [
	<return: #GtPageElement>
	^ playPageElement
]

{ #category : #'private - accessing' }
GtInspectorPlaygroundElement >> resizerElement [
	^ resizerElement
]

{ #category : #'private - updating' }
GtInspectorPlaygroundElement >> updatePlayPage [
	self playPage receiver: self object.
	self playPage xDocLoadSavedContent.
]
