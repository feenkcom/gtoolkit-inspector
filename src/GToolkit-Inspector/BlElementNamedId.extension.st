Extension { #name : #BlElementNamedId }

{ #category : #'*GToolkit-Inspector' }
BlElementNamedId >> gtReferencesFor: aView [
	<gtView>
	self identifier ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'References';
		object: [ self asSymbol gtSenders ];
		view: #gtItemsFor:
]
