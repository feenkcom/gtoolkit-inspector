Extension { #name : #BrTextHoverStylableAttribute }

{ #category : #'*GToolkit-Inspector' }
BrTextHoverStylableAttribute >> gtAttributesFor: aView [
	<gtView>
	self attributes ifNil: [ ^ aView empty ].
	^ aView list 
		title: 'Attributes';
		items: [ self attributes ]
]
