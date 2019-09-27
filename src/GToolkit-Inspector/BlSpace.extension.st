Extension { #name : #BlSpace }

{ #category : #'*GToolkit-Inspector' }
BlSpace >> gtPreviewFor: aView [
	<gtView>
	self root ifNil: [ ^ aView empty ].
	^ self root gtPreviewFor: aView

]
