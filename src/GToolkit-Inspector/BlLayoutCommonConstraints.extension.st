Extension { #name : #BlLayoutCommonConstraints }

{ #category : #'*GToolkit-Inspector' }
BlLayoutCommonConstraints >> gtConstraintsFor: aView [ 
	<gtView>
	constraints ifNil: [ ^ aView empty ].
	^ aView forward 
		title: 'Constraints';
		object: [ constraints ];
		view: #gtItemsFor:
]
