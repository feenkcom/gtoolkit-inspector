Class {
	#name : #GtPagerHolder,
	#superclass : #GtPagerProtoHolder,
	#instVars : [
		'pager'
	],
	#category : #'GToolkit-Pager-Strategies'
}

{ #category : #factory }
GtPagerHolder class >> null [
	^ GtPagerNullHolder default
]

{ #category : #'api - actions' }
GtPagerHolder >> close: aPageElement [
	"Close/remove a page from a pager"
	self pager removePage: aPageElement.
]

{ #category : #'api - actions' }
GtPagerHolder >> maximizePageContent: aContentElement [
	| anOverlay aPreviousParent aMinimizeButton anOverlayContent |
	aPreviousParent := aContentElement parent.
	aContentElement removeFromParent.
	anOverlayContent := BlElement new.
	anOverlay := BlOverlayElement new.
	anOverlay
		background: (Color white alpha: 0.8);
		padding: (BlInsets all: 20);
		attachTo: self pager;
		layout: BlLinearLayout horizontal.
	anOverlayContent
		background: (Color white);
		look: BrShadowLook new;
		constraintsDo: [ :c | c horizontal matchParent. c vertical matchParent ];
		clipChildren: false;
		addChild: aContentElement.
	anOverlay addChild: anOverlayContent.
	aMinimizeButton := GtInspectorRoundButtonStencil normal asElement
		icon: GtInspectorMinusIconStencil minus asElement;
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c margin: (BlInsets top: -10 left: -10 bottom: 0 right: 0).
			c ignored horizontal alignLeft.
			c ignored vertical alignTop ];
		action: [ 
			aContentElement removeFromParent.
			aPreviousParent addChildFirst: aContentElement.
			anOverlay removeFromParent ].
	anOverlayContent addChild: aMinimizeButton.
	self pager addChild: anOverlay
]

{ #category : #accessing }
GtPagerHolder >> pager [
	^ pager
]

{ #category : #accessing }
GtPagerHolder >> pager: anObject [
	pager := anObject
]
