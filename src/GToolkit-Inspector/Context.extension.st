Extension { #name : #Context }

{ #category : #'*GToolkit-Inspector' }
Context >> gtSourceFor: aView [
	<gtView>
	self method ifNil: [ ^ aView empty ].
	^ self method gtSourceFor: aView
]

{ #category : #'*GToolkit-Inspector' }
Context >> gtStackFor: aView [
	<gtView>
	^ aView list
		title: 'Stack';
		items: [self stack]
]
