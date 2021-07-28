Extension { #name : #ZnDispatcherDelegate }

{ #category : #'*GToolkit-Inspector' }
ZnDispatcherDelegate >> gtMapFor: aView [
	<gtView>
	^ self dispatcherDictionary gtItemsFor: aView
]
