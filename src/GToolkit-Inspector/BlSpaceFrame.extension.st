Extension { #name : #BlSpaceFrame }

{ #category : #'*GToolkit-Inspector' }
BlSpaceFrame >> gtPhasesFor: aView [
	<gtView>
	^ aView list
		title: 'Phases';
		items: [ self phases ];
		itemText: [ :each | 
			each = self currentPhase
				ifTrue: [ (each name , ' (current phase)') asRopedText bold ]
				ifFalse: [ each name ] ]
]
