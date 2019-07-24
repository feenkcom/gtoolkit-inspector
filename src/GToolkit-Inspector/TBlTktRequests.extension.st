Extension { #name : #TBlTktRequests }

{ #category : #'*GToolkit-Inspector' }
TBlTktRequests >> gtInvocatedByElementPreviewFor: aView [
	<gtView>
	self invocatedByElement ifNil: [ ^ aView empty ].
	^ (self invocatedByElement gtPreviewFor: aView)
			title: 'Element'
]

{ #category : #'*GToolkit-Inspector' }
TBlTktRequests >> gtUserDataFor: aView [
	<gtView>
	self userData ifEmpty: [ ^ aView empty ].
	^ (self userData gtItemsFor: aView)
			title: 'User Data'
]
