Extension { #name : #BlProcess }

{ #category : #'*GToolkit-Inspector' }
BlProcess >> gtInvocatedByElementPreviewFor: aView [
	<gtView>
	^ self invocatedByElement 
		ifNil: [ ^ aView empty ]
		ifNotNil: [ :anElement | (anElement gtPreviewFor: aView)
			title: 'Element' ]
]
