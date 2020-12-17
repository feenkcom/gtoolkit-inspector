Extension { #name : #BlDevScripter }

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
