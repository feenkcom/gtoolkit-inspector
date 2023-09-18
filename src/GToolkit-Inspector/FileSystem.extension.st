Extension { #name : #FileSystem }

{ #category : #'*GToolkit-Inspector' }
FileSystem >> gtRootItemsFor: aView [
	<gtView>
	self root ifNil: [ ^ aView empty ].
	^ (self root gtItemsFor: aView)
		title: 'Root directory'
]

{ #category : #'*GToolkit-Inspector' }
FileSystem >> gtWorkingItemsFor: aView [
	<gtView>
	self workingDirectory ifNil: [ ^ aView empty ].
	^ (self workingDirectory gtItemsFor: aView)
		title: 'Working directory'
]
