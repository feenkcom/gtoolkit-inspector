Extension { #name : #BlRope }

{ #category : #'*GToolkit-Inspector' }
BlRope >> gtTreeFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Tree';
		painting: [ :mondrian| self paintTreeWith: mondrian ]
]
