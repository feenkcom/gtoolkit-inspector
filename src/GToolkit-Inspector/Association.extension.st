Extension { #name : #Association }

{ #category : #'*GToolkit-Inspector' }
Association >> gtAssociationViewLiveFor: aView [
	<gtView>
	^ aView forward
		title: 'Value';
		priority: 1;
		object: [ self value ];
		view: #gtLiveFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			tooltip: 'Inspect value' 
			action: [ :aButton :aTab | 
				aButton phlow spawnObject: self value ]
]

{ #category : #'*GToolkit-Inspector' }
Association >> gtPreviewFor: aView [
	<gtView>
	^ aView explicit
		title: 'Preview';
		stencil: [ self newPreviewStencil ]
]

{ #category : #'*GToolkit-Inspector' }
Association >> newPreviewStencil [
	| aContainer aKeyElement anArrowElement aValueElement |
	aKeyElement := BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude;
		label: self key asString;
		action: [ :aButton | aButton phlow spawnObject: self key ];
		constraintsDo: [ :c | c linear horizontal alignCenter ].
	aValueElement := BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude;
		label: self value asString;
		action: [ :aButton | aButton phlow spawnObject: self value ];
		constraintsDo: [ :c | c linear horizontal alignCenter ].
	anArrowElement := BrGlamorousVectorIcons right asElement
		constraintsDo: [ :c | 
			c margin: (BlInsets left: 5 right: 5).
			c linear horizontal alignCenter ].
	aContainer := BlElement new
		layout: BlLinearLayout horizontal alignCenter;
		aptitude: BrShadowAptitude;
		background: Color white;
		margin: (BlInsets all: 20);
		padding: (BlInsets all: 20);
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent.
			c frame horizontal alignCenter.
			c frame vertical alignCenter ].
	aContainer
		addChild: aKeyElement;
		addChild: anArrowElement;
		addChild: aValueElement.
	^ BlElement new
		layout: BlFrameLayout new;
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent ];
		addChild: aContainer
]
