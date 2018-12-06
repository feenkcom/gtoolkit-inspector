Extension { #name : #BlCompositeAnimation }

{ #category : #'*GToolkit-Inspector' }
BlCompositeAnimation >> gtAnimationsFor: aView [
	<gtView>

	^ aView list
		title: 'Animations';
		priority: 10;
		items: [ self animations ]
]
