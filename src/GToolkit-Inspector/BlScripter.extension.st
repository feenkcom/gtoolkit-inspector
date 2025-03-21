Extension { #name : #BlScripter }

{ #category : #'*GToolkit-Inspector' }
BlScripter >> gtElementsFor: aView [
	<gtView>
	space ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Elements';
		object: [ self space root ];
		view: #gtChildrenFor:
]

{ #category : #'*GToolkit-Inspector' }
BlScripter >> gtEventTracesIn: aContainer [
	| anEventColor|

	anEventColor := Color r: 0.270772238514174 g: 0.6705767350928641 b: 0.9960899315738025 alpha: 1.0.
	
	self events do: [ :eachEvent |
		eachEvent class = BlMouseDownEvent
			ifTrue: [
				aContainer addChild: (BlElement new
					geometry: (BlCircleGeometry new);
					size: 6@6;
					constraintsDo: [ :c | c ignoreByLayout ];
					background: anEventColor;
					border: (BlBorder paint: Color white width: 1);
					relocate: eachEvent position - (3@3)) ].
				
		eachEvent class = BlMouseUpEvent
			ifTrue: [
				aContainer addChild: (BlElement new
					geometry: (BlCircleGeometry new);
					size: 6@6;
					constraintsDo: [ :c | c ignoreByLayout ];
					background: anEventColor;
					border: (BlBorder paint: anEventColor width: 1);
					relocate: eachEvent position - (3@3)) ].
				
		eachEvent class = BlClickEvent
			ifTrue: [
				aContainer addChild: (BlElement new
					geometry: (BlCircleGeometry new);
					size: 12@12;
					constraintsDo: [ :c | c ignoreByLayout ];
					background: (Color white alpha: 0.25);
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
BlScripter >> gtEventsFor: aView [
	<gtView>
	self events ifNil: [ ^ aView empty ].
	^ (self events gtEventsFor: aView)
		title: 'Events';
		priority: 3
]

{ #category : #'*GToolkit-Inspector' }
BlScripter >> gtReveresedEventsFor: aView [
	<gtView>
	self events ifNil: [ ^ aView empty ].
	^ (self events gtReveresedEventsFor: aView)
		title: 'Events (Reversed)';
		priority: 4
]

{ #category : #'*GToolkit-Inspector' }
BlScripter >> gtSpaceFor: aView [
	<gtView>
	space ifNil: [ ^ aView empty ].
	element ifNil: [ ^ aView empty ].

	^ aView explicit
		title: 'Preview';
		priority: 0;
		stencil: [ self gtSpacePreview ];
		actionButtonLabel: 'Open space'
			tooltip: 'Open scripter space in a real window'
			action: [ self showSpace ];
		actionButtonIcon: BrGlamorousIcons inspect 
			label: 'Element'
			tooltip: 'Inspect element (remove it from the Scripter space)'
			action: [ :anElement | anElement phlow spawnObject: self elementWithoutParent ]
]

{ #category : #'*GToolkit-Inspector' }
BlScripter >> gtSpacePreview [
	| aContainer |
	aContainer := BrVerticalPane new matchParent.
	(self space gtPreviewFor: GtPhlowEmptyView new)
		asElementDo: [ :anElement | 
			anElement
				childWithId: #'element-preview--content'
				ifFound: [ :aContent | self gtEventTracesIn: aContent ].
			aContainer addChild: anElement ].
	^ aContainer
]

{ #category : #'*GToolkit-Inspector' }
BlScripter >> gtSpaceSimplePreview [
	| aContainer |
	aContainer := BrVerticalPane new matchParent.
	(self space gtPreviewFor: GtPhlowEmptyView new)
		asElementDo: [ :anElement |
			aContainer when: BlClickEvent do: [ :anEvent |
				self gtOnPreviewClickEvent: anEvent ].
			aContainer addChild: anElement ].
	^ aContainer
]

{ #category : #'*GToolkit-Inspector' }
BlScripter >> gtSpaceSimplePreviewFor: aView [
	space ifNil: [ ^ aView empty ].
	element ifNil: [ ^ aView empty ].

	^ aView explicit
		title: 'Preview';
		priority: 0;
		stencil: [ self gtSpaceSimplePreview ];
		actionButtonLabel: 'Open space'
			tooltip: 'Open scripter space in a real window'
			action: [ self showSpace ];
		actionButtonIcon: BrGlamorousIcons inspect 
			label: 'Element'
			tooltip: 'Inspect element (remove it from the Scripter space)'
			action: [ :anElement | anElement phlow spawnObject: self elementWithoutParent ]
]

{ #category : #'*GToolkit-Inspector' }
BlScripter >> gtStepsMondrianTreeFor: aView [
	<gtView>
	
	^ rootStep gtStepsMondrianTreeFor: aView
]

{ #category : #'*GToolkit-Inspector' }
BlScripter >> gtStepsTreeFor: aView [
	<gtView>
	
	^ rootStep gtStepsTreeFor: aView
]

{ #category : #'*GToolkit-Inspector' }
BlScripter >> gtTaskEventsFor: aView [
	<gtView>
	self events ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Tasks';
		priority: 2;
		items: [ self spaceTaskEvents ];
		column: 'Frame id'
			text: [ :eachEvent | eachEvent frameId ]
			width: 75;
		column: 'Event'
			text: [ :eachEvent | 
				eachEvent isTaskEnqueuedEvent
					ifTrue: [ 'Enqueued' asRopedText foreground: BrGlamorousColors linkColor darker ]
					ifFalse: [ eachEvent isTaskDequeuedEvent
							ifTrue: [ 'Dequeued' asRopedText foreground: BrGlamorousColors errorBorderColor ]
							ifFalse: [ eachEvent isTaskExecutedEvent
									ifTrue: [ 'Executed' asRopedText
											foreground: BrGlamorousColors successBackgroundColor darker ]
									ifFalse: [ eachEvent isTaskRequeuedEvent
											ifTrue: [ 'Requeued' asRopedText foreground: Color gray ]
											ifFalse: [ 'Unknown' ] ] ] ] ]
			width: 100;
		column: 'Task id'
			text: [ :eachEvent | eachEvent task id ]
			width: 75;
		column: 'Tasks'
			text: [ :eachEvent | eachEvent tasks size ]
			width: 75;
		column: 'Source Process'
			text: [ :eachEvent | eachEvent task processId ]
			width: 120;
		column: 'Description' text: [ :eachEvent | eachEvent task printString ]
]

{ #category : #'*GToolkit-Inspector' }
BlScripter >> gtUserDataFor: aView [
	<gtView>
	space ifNil: [ ^ aView empty ].
	self userData isEmpty ifTrue: [ ^ aView empty ].
	^ (self userData gtUserDataFor: aView)
		priority: 7
]
