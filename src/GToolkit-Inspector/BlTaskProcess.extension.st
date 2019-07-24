Extension { #name : #BlTaskProcess }

{ #category : #'*GToolkit-Inspector' }
BlTaskProcess >> gtInvocatedByElementPreviewFor: aView [
	<gtView>
	^ self invocatedByElement 
		ifNil: [ ^ aView empty ]
		ifNotNil: [ :anElement | (anElement gtPreviewFor: aView)
			title: 'Element' ]
]
