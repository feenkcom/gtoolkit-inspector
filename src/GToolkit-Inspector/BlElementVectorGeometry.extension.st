Extension { #name : #BlElementVectorGeometry }

{ #category : #'*GToolkit-Inspector' }
BlElementVectorGeometry >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		stencil: [ self asElement ]
]
