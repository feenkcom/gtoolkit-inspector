Extension { #name : #BlSpaceFrame }

{ #category : #'*GToolkit-Inspector' }
BlSpaceFrame >> gtPhasesFor: aView [
	<gtView>
	
	^ aView list
		title: 'Phases';
		items: [ self phases ];
		itemFormat: [ :each | each = self currentPhase
			ifTrue: [ (each name, ' (current phase)') asRopedText bold ]
			ifFalse: [ each name ] ]
]
