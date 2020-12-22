Extension { #name : #BlElementNamedId }

{ #category : #'*GToolkit-Inspector' }
BlElementNamedId >> gtReferencesFor: aView [
	<gtView>
	self identifier ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'References';
		stencil: [ self asSymbol gtSenders ]
]
