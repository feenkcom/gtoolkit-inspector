Extension { #name : #BlRope }

{ #category : #'*GToolkit-Inspector' }
BlRope >> gtTreeFor: aView [
	<gtView>
	^ aView explicit
		title: 'Tree';
		stencil: [ 
			| mondrian |
			mondrian := GtMondrian new.
			self paintTreeWith: mondrian.
			mondrian asPannableElement ]
]
