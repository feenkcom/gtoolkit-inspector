Extension { #name : #ZnHeaders }

{ #category : #'*GToolkit-Inspector' }
ZnHeaders >> gtHeadersFor: aView [
	<gtView>
	^ (self headers gtItemsFor: aView)
			title: (self headers size asString, ' items');
			priority: 30
]
