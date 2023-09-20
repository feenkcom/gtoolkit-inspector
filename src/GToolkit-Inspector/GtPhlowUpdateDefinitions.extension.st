Extension { #name : #GtPhlowUpdateDefinitions }

{ #category : #'*GToolkit-Inspector' }
GtPhlowUpdateDefinitions >> gtDefinitionsFor: aView [
	<gtView>
	self definitions ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Definitions';
		items: [ self definitions ];
		actionUpdateButtonTooltip: 'Update definitions'
]
