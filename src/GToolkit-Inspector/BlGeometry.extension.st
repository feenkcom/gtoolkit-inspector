Extension { #name : #BlGeometry }

{ #category : #'*GToolkit-Inspector' }
BlGeometry >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		stencil: [ self asElement ]
]
