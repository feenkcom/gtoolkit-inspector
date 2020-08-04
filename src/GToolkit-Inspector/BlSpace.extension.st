Extension { #name : #BlSpace }

{ #category : #'*GToolkit-Inspector' }
BlSpace >> gtChildrenFor: aView [
	<gtView>
	self root ifNil: [ ^ aView empty ].
	^ aView forward 
		title: 'Children';
		priority: 35;
		object: [ self root ];
		view: #gtChildrenFor:
]

{ #category : #'*GToolkit-Inspector' }
BlSpace >> gtPreviewFor: aView [
	<gtView>
	self root ifNil: [ ^ aView empty ].
	^ self root gtPreviewFor: aView

]
