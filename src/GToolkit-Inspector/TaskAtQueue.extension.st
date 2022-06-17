Extension { #name : #TaskAtQueue }

{ #category : #'*GToolkit-Inspector' }
TaskAtQueue >> gtItemsFor: aView [
	<gtView>
	queue ifNil: [ ^ self ].
	^ (queue gtItemsFor: aView)
		title: 'Tasks'
]
