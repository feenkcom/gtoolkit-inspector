Extension { #name : #BlTaskAtQueue }

{ #category : #'*GToolkit-Inspector' }
BlTaskAtQueue >> gtItemsFor: aView [
	<gtView>
	queue ifNil: [ ^ self ].
	^ (queue gtItemsFor: aView)
		title: 'Tasks'
]
