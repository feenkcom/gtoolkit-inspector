"
I preview {{gtClass:BlElement}} instances. If possible, I preview elements live (as my child) to be able to interact with them. I preview elements statically (a screenshot) otherwise.

#Example
The following two inspectors display a same {{gtClass:BlElement | label=element}} instance. Try to switch between `Live` and `Overview` tabs in both panes to see how it behaves. {{gtExample: GtInspectorElementLiveViewContainerByScripterExamples >> #twoPagerPagesWithInspectedElement | noCode | previewHeight=500 | previewShow=gtLiveFor: }}
"
Class {
	#name : #GtInspectorElementLiveViewContainer,
	#superclass : #BlElement,
	#instVars : [
		'element',
		'onElementRemovedHandler'
	],
	#category : #'GToolkit-Inspector-Extensions Support'
}

{ #category : #accessing }
GtInspectorElementLiveViewContainer >> element [
	^ element
]

{ #category : #accessing }
GtInspectorElementLiveViewContainer >> element: anElement [
	self
		assert: [ element isNil ]
		description: [ 'Element can be initialized only once.' ].
	self
		assert: [ anElement isNotNil ]
		description: [ 'Element must be non-nil.' ].
	self
		assert: [ anElement isKindOf: BlElement ]
		description: [ 'Element must be kind of ', BlElement name, '.' ].

	element := anElement.
	
	BlUseAsyncFeatures ifDisabledDo: [ self updateElementLiveView ]
]

{ #category : #'private - updating' }
GtInspectorElementLiveViewContainer >> gtOnPreviewClickEvent: anEvent [
	| aPreviewElement aLocalPosition aClickedElement aGlobalPosition |
	element space ifNil: [ ^ self ].
	aPreviewElement := anEvent currentTarget.
	aLocalPosition := aPreviewElement globalPointToLocal: anEvent position.
	aGlobalPosition := element localPointToGlobal: aLocalPosition.
	aClickedElement := element findMouseEventTargetAt: aGlobalPosition.
	aPreviewElement phlow spawnObject: aClickedElement
]

{ #category : #initialization }
GtInspectorElementLiveViewContainer >> initialize [
	"The element should use {{gtClass:BasicLayout}} to be able to
	use #relocate: for particular views (use cases). Note, that
	using #padding: in this case does not have any effect."

	super initialize.
	
	onElementRemovedHandler := BlEventHandler 
		on: BlElementRemovedFromSceneGraphEvent 
		do: [ :anEvent | 
			self onElementRemovedFromSceneGraphEvent: anEvent ].

	self
		background: self theme default contentBackground;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	self when: BlClickEvent do: [ :event | self requestFocus ]
]

{ #category : #testing }
GtInspectorElementLiveViewContainer >> isElementLiveView [
	^ element isNotNil
		and: [ self childrenCount = 1 and: [ (self childAt: 1) == element ] ]
]

{ #category : #testing }
GtInspectorElementLiveViewContainer >> isElementPreviewView [
	^ element isNotNil
		and: [ self childrenCount = 2
				and: [ (self childAt: 1) id = GtInspectorElementPreviewContainerId uniqueInstance ] ]
]

{ #category : #'private - testing' }
GtInspectorElementLiveViewContainer >> isMyLiveView [
	element ifNil: [ ^ false ].
	^ element parent == self
]

{ #category : #'private - testing' }
GtInspectorElementLiveViewContainer >> isReadyForLiveView [
	"Return true if element view should be changed to (or displayed as) a live view."
	<return: #Boolean>

	element ifNil: [ ^ false ].
	
	element parent == self ifTrue: [ 
		"The element is already previewed as live by me, therefore do not update it"
		^ false ].
	
	element isRoot ifTrue: [ 
		"Space root elements are always previewed."
		^ false ].

	element hasParent ifTrue: [
		(element parent isKindOf: GtInspectorElementLiveViewContainer)
			ifTrue: [
				"If the container is not added to the scene graph,
				take the element from the container and display the element as live."
				^ element parent isAddedToSceneGraph not ].
				
		"The element is a part of a 'real' UI (not as an inspected element). 
		Do not display it as live."
		^ false ].

	"The element is not displayed (used) anywhere, display it live."
	^ true
]

{ #category : #'private - updating' }
GtInspectorElementLiveViewContainer >> isReadyForPreviewView [
	"Return true if element view should be changed to (or displayed as) a preview view."
	<return: #Boolean>

	element ifNil: [ ^ false ].	
	
	element parent == self ifTrue: [ 
		"The element is already previewed as live by me, therefore do not update it."
		^ false ].
		
	self isElementPreviewView ifTrue: [
		"The element is already previewed by me, 
		therefore do not update it."
		^ false ].
		
	element isRoot ifTrue: [ 
		"Space root elements are always previewed."
		^ true ].
	
	element hasParent ifTrue: [ 
		(element parent isKindOf: GtInspectorElementLiveViewContainer)
			ifTrue: [ 
				"If the container is added to the scene graph,
				display the element as a preview."
				^ element parent isAddedToSceneGraph ].
				
		"The element is a part of a 'real' UI (not as an inspected element). 
		Display it as a preview."
		^ true ].

	"The element is not displayed (used) anywhere, display it as a preview."
	^ true
]

{ #category : #'hooks - children' }
GtInspectorElementLiveViewContainer >> onAddedToSceneGraph [
	super onAddedToSceneGraph.

	self registerElementHandlers.
	self updateElementLiveView
]

{ #category : #'hooks - children' }
GtInspectorElementLiveViewContainer >> onChildAdded: anElement [
	super onChildAdded: anElement.
	
	anElement id = GtInspectorElementPreviewContainerId asBlocElementId 
		ifTrue: [ ^ self ].
	
	"In case someone uses code like 
	`anElement parent replaceChild: anElement with: aNewElement`,
	we establish the new provided child as a new inspected element."
	(self childrenCount = 1 and: [ (anElement == self element) not ]) ifTrue: [
		element := anElement ]
]

{ #category : #'private - event handling' }
GtInspectorElementLiveViewContainer >> onElementRemovedFromSceneGraphEvent: anEvent [
	self updateElementLiveView
]

{ #category : #'hooks - children' }
GtInspectorElementLiveViewContainer >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.

	self unregisterElementHandlers
]

{ #category : #'private - updating' }
GtInspectorElementLiveViewContainer >> registerElementHandlers [
	element ifNil: [ ^ self ].
	element addEventHandler: onElementRemovedHandler.
]

{ #category : #'private - updating' }
GtInspectorElementLiveViewContainer >> unregisterElementHandlers [
	element ifNil: [ ^ self ].
	element removeEventHandler: onElementRemovedHandler
]

{ #category : #'private - updating' }
GtInspectorElementLiveViewContainer >> updateAsElementLiveView [
	self removeChildren.
	
	"Please don't change the layout of the container to anything except the default layout,
	otherwise `relocate:` will not longer work as expected and element will always be in the top left corner."
	self layout: self defaultLayout.

	element removeFromParent.
	self addChild: element
]

{ #category : #'private - updating' }
GtInspectorElementLiveViewContainer >> updateAsElementPreviewView [
	| label previewContainer scaledPreview preview |
	self removeChildren.
	self margin: (BlInsets all: 10).

	self layout: BlLinearLayout vertical.

	preview := [ element asSpartaForm asElement ]
		on: Error
		do: [ :anException | 
			anException asDebuggableElement ].
	scaledPreview := preview asScalableElement maxScale: 1.0.

	preview
		when: BlClickEvent
		do: [ :anEvent | self gtOnPreviewClickEvent: anEvent ].

	previewContainer := BlElement new
			aptitude: BrShadowAptitude;
			layout: BlLinearLayout new;
			background: Color white;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			addChild: scaledPreview as: #preview.

	label := BrLabel new
			aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
			text: 'You see a static preview because this element already has a parent.'
					asRopedText glamorousRegularFont readonly;
			alignCenter;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical fitContent.
				c linear horizontal alignCenter ].

	self addChild: previewContainer as: GtInspectorElementPreviewContainerId.
	self addChild: label as: #description
]

{ #category : #'private - updating' }
GtInspectorElementLiveViewContainer >> updateElementLiveView [
	element ifNil: [ ^ self ].

	self isMyLiveView ifTrue: [ ^ self ].
	
	self isReadyForLiveView ifTrue: [
		self updateAsElementLiveView ].
	
	self isReadyForPreviewView ifTrue: [ 
		self updateAsElementPreviewView ].
]
