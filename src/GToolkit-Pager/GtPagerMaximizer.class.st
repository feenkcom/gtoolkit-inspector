Class {
	#name : #GtPagerMaximizer,
	#superclass : #Object,
	#traits : 'TBlDebug + TGtContentElementAccessors + TGtPagerAccessors',
	#classTraits : 'TBlDebug classTrait + TGtContentElementAccessors classTrait + TGtPagerAccessors classTrait',
	#category : #'GToolkit-Pager-Stencils and Builders'
}

{ #category : #'host space - displaying' }
GtPagerMaximizer >> maximize [
	| anOverlay aPreviousParent aMinimizeButton anOverlayContent |
	aPreviousParent := self contentElement parent.
	self contentElement removeFromParent.
	anOverlay := self newOverlay.
	anOverlayContent := self newOverlayContent.
	anOverlay addChild: anOverlayContent.
	aMinimizeButton := self newMinimizeIcon
		action: [ 
			self contentElement removeFromParent.
			aPreviousParent addChildFirst: self contentElement.
			anOverlay removeFromParent.
			self notifyMinimized ].
	anOverlayContent addChild: aMinimizeButton.
	self pager addChild: anOverlay.
	self notifyMaximized.
]

{ #category : #'instance creation' }
GtPagerMaximizer >> newMinimizeIcon [
	^ GtInspectorRoundButtonStencil normal asElement
		icon: GtInspectorMinusIconStencil minus asElement;
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c margin: (BlInsets top: -10 left: -10 bottom: 0 right: 0).
			c ignored horizontal alignLeft.
			c ignored vertical alignTop ]
]

{ #category : #'instance creation' }
GtPagerMaximizer >> newOverlay [
	^ BlOverlayElement new
		background: (Color white alpha: 0.8);
		padding: (BlInsets all: 20);
		attachTo: self pager;
		layout: BlLinearLayout horizontal
]

{ #category : #'instance creation' }
GtPagerMaximizer >> newOverlayContent [
	^ BlElement new
		background: (Color white);
		look: BrShadowLook new;
		constraintsDo: [ :c | c horizontal matchParent. c vertical matchParent ];
		clipChildren: false;
		addChild: self contentElement.
]

{ #category : #notifying }
GtPagerMaximizer >> notifyMaximized [
	self contentElement tool 
		dispatchEvent: (GtPagerPageMaximizedEvent new
			pager: self pager;
			page: self contentElement viewModel)
]

{ #category : #notifying }
GtPagerMaximizer >> notifyMinimized [
	self contentElement tool 
		dispatchEvent: (GtPagerPageMinimizedEvent new
			pager: self pager;
			page: self contentElement viewModel)
]
