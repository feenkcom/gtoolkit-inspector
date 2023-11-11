Extension { #name : #BlEventHandler }

{ #category : #'*GToolkit-Inspector' }
BlEventHandler >> gtActionFor: aView [
	<gtView>
	self action ifNil: [ ^ aView empty ].
	^ (self action gtSourceCodeFor: aView)
		title: 'Action';
		priority: 20
]
