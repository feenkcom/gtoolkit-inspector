Extension { #name : #BlAttributeRope }

{ #category : #'*GToolkit-Inspector' }
BlAttributeRope >> gtAttributesFor: aView [
	<gtView>
	self attributes ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Attributes' translated;
		items: self attributes
]
