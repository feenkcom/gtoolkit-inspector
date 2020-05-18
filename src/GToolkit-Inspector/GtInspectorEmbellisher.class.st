Class {
	#name : #GtInspectorEmbellisher,
	#superclass : #GtPagerPageEmbellisher,
	#instVars : [
		'object'
	],
	#category : #'GToolkit-Inspector-Stencils'
}

{ #category : #'widget configuration' }
GtInspectorEmbellisher >> addPlaygroundIn: aCreationContext [
	| aPlaygroundContainer aContentToPlaygroundResizer aPlayground aPlayBook |
	aPlaygroundContainer := BlElement new
		padding: (BlInsets all: 10);
		layout: BlLinearLayout new;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: 0 ].
	aPlayBook := GtPlayPage forObject: self object.
	aPlayground := aPlayBook asElement.
	aPlayground
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	aPlayground clipChildren: false.
	aPlaygroundContainer addChild: aPlayground.
	aContentToPlaygroundResizer := GtEmbeddedPlaygroundResizer new
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

{ #category : #'widget configuration' }
GtInspectorEmbellisher >> fillContentWrapperIn: aCreationContext [
	super fillContentWrapperIn: aCreationContext.
	self addPlaygroundIn: aCreationContext.
]

{ #category : #accessing }
GtInspectorEmbellisher >> object [
	^ object
]

{ #category : #accessing }
GtInspectorEmbellisher >> object: anObject [
	object := anObject
]
