Class {
	#name : #GtInspectorEmbeddedPlayground,
	#superclass : #GtInspectorExtension,
	#instVars : [
		'object',
		'playBook'
	],
	#category : #'GToolkit-Inspector-Model'
}

{ #category : #'widget configuration' }
GtInspectorEmbeddedPlayground >> addPlaygroundIn: aCreationContext [
	| aPlaygroundContainer aContentToPlaygroundResizer aPlayground |
	aPlaygroundContainer := BlElement new
		padding: (BlInsets all: 10);
		layout: BlLinearLayout new;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: 0 ].
	playBook := GtPlayPage forObject: self object.
	aPlayground := playBook asElement.
	aPlayground
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	aPlayground clipChildren: false.
	aPlaygroundContainer addChild: aPlayground.
	aContentToPlaygroundResizer := GtInspectorPagePlaygroundResizer new
		layout: BlFrameLayout new;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: 8.
			c margin: (BlInsets left: 40 right: 40).
			c padding: (BlInsets all: 0) ];
		addChild:
			(BlElement new
				background: ((Color fromHexString: #BDBDBD) alpha: 0.5);
				geometry: (BlRectangle cornerRadius: 2);
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical exact: 3.
					c frame horizontal weight: 0.2.
					c frame vertical alignTop.
					c frame horizontal alignCenter ]);
		addEventHandler:
			(BlResizerTopListener new
				resizeTarget: aPlaygroundContainer;
				minimumExtent: 75 @ 0);
		when: BlDoubleClickEvent
			do: [ :e | aPlaygroundContainer height: 0 ].
	aCreationContext wrapperElement 
		addChild: aContentToPlaygroundResizer;
		addChild: aPlaygroundContainer.
]

{ #category : #notifications }
GtInspectorEmbeddedPlayground >> addedToSceneGraph [
	"do nothing"
]

{ #category : #'widget configuration' }
GtInspectorEmbeddedPlayground >> fillToolWidgetIn: aCreationContext [
	self addPlaygroundIn: aCreationContext
]

{ #category : #accessing }
GtInspectorEmbeddedPlayground >> inspectorInstance: anInspector [
	self object: anInspector object
]

{ #category : #accessing }
GtInspectorEmbeddedPlayground >> object [
	^ object
]

{ #category : #accessing }
GtInspectorEmbeddedPlayground >> object: anObject [
	object := anObject.
	self onObjectChanged.
]

{ #category : #notifications }
GtInspectorEmbeddedPlayground >> objectChangedTo: anObject [
	self object: anObject
]

{ #category : #notifications }
GtInspectorEmbeddedPlayground >> objectRemoved [
	self object: nil
]

{ #category : #hooks }
GtInspectorEmbeddedPlayground >> onObjectChanged [
	playBook ifNil: [ ^ self ].
	playBook receiver: self object.
]

{ #category : #notifications }
GtInspectorEmbeddedPlayground >> removedFromSceneGraph [
	"do nothing"
]
