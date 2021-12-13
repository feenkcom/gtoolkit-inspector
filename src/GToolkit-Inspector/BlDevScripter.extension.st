Extension { #name : #BlDevScripter }

{ #category : #'*GToolkit-Inspector' }
BlDevScripter >> gtElementsFor: aView [
	<gtView>
	space ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Children';
		object: [ self space root ];
		view: #gtChildrenFor:
]

{ #category : #'*GToolkit-Inspector' }
BlDevScripter >> gtEventTracesIn: aContainer [
	| anEventColor |
	
	anEventColor := Color r: 0.270772238514174 g: 0.6705767350928641 b: 0.9960899315738025 alpha: 1.0.
	
	self events do: [ :eachEvent |
		eachEvent class = BlMouseDownEvent
			ifTrue: [
				aContainer addChild: (BlElement new
					geometry: (BlCircleGeometry new);
					size: 6@6;
					background: anEventColor;
					effect: (BlGaussianShadowEffect
						color: anEventColor
						width: 1
						offset: 0@0);
					border: (BlBorder paint: Color white width: 1);
					relocate: eachEvent position - (3@3)) ].
				
		eachEvent class = BlMouseUpEvent
			ifTrue: [
				aContainer addChild: (BlElement new
					geometry: (BlCircleGeometry new);
					size: 6@6;
					background: Color white;
					border: (BlBorder paint: anEventColor width: 1);
					effect: (BlGaussianShadowEffect
						color: anEventColor
						width: 1
						offset: 0@0);
					relocate: eachEvent position - (3@3)) ].
				
		eachEvent class = BlClickEvent
			ifTrue: [
				aContainer addChild: (BlElement new
					geometry: (BlCircleGeometry new);
					size: 12@12;
					background: Color transparent;
					border: (BlBorder paint: anEventColor width: 1);
					relocate: eachEvent position - (6@6)) ].
		
		eachEvent class = BlMouseMoveEvent
			ifTrue: [
				aContainer addChild: (BlLineElement new
					border: (BlBorder paint: anEventColor width: 1);
					fromAnchor: (BlAbsolutePositionAnchor position: eachEvent position - eachEvent delta);
					toAnchor: (BlAbsolutePositionAnchor position: eachEvent position)) ] ]
]

{ #category : #'*GToolkit-Inspector' }
BlDevScripter >> gtEventsFor: aView [
	<gtView>
	self events ifNil: [ ^ aView empty ].
	^ (self events gtEventsFor: aView)
		title: 'Events';
		priority: 3
]

{ #category : #'*GToolkit-Inspector' }
BlDevScripter >> gtReveresedEventsFor: aView [
	<gtView>
	self events ifNil: [ ^ aView empty ].
	^ (self events gtReveresedEventsFor: aView)
		title: 'Events (Reversed)';
		priority: 4
]

{ #category : #'*GToolkit-Inspector' }
BlDevScripter >> gtSpaceFor: aView [
	<gtView>
	space ifNil: [ ^ aView empty ].
	element ifNil: [ ^ aView empty ].
		
	^ aView explicit
		title: 'Preview';
		priority: 0;
		stencil: [
			| aContainer |
			
			aContainer := BlElement new.
			aContainer constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ].
			
			(self space gtPreviewFor: GtPhlowEmptyView new)
				asElementDo: [ :anElement | aContainer addChild: anElement ].
			
			self gtEventTracesIn: aContainer.
			
			aContainer ];
		actionButtonLabel: 'Open' 
			tooltip: 'Open scripter space in a real window'
			action: [ self showSpace ];
		actionButtonLabel: 'Inspect'
			tooltip: 'Inspect element (remove it from the Scripter space)' 
			action: [ :anElement | 
				anElement phlow spawnObject: self elementWithoutParent ]
]

{ #category : #'*GToolkit-Inspector' }
BlDevScripter >> gtSpaceTasksFor: aView [
	<gtView>
	space ifNil: [ ^ aView empty ].
	self spaceTasks ifEmpty: [ ^ aView empty ].
	^ (self spaceTasks gtItemsFor: aView)
		title: 'Space Tasks'
]

{ #category : #'*GToolkit-Inspector' }
BlDevScripter >> gtStepsMondrianTreeFor: aView [
	<gtView>
	
	^ rootStep gtStepsMondrianTreeFor: aView
]

{ #category : #'*GToolkit-Inspector' }
BlDevScripter >> gtStepsTreeFor: aView [
	<gtView>
	
	^ rootStep gtStepsTreeFor: aView
]

{ #category : #'*GToolkit-Inspector' }
BlDevScripter >> gtUserDataFor: aView [
	<gtView>
	space ifNil: [ ^ aView empty ].
	self userData isEmpty ifTrue: [ ^ aView empty ].
	^ (self userData gtUserDataFor: aView)
		priority: 7
]
