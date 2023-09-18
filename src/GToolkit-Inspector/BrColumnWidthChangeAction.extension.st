Extension { #name : #BrColumnWidthChangeAction }

{ #category : #'*GToolkit-Inspector' }
BrColumnWidthChangeAction >> gtMethodSendersFor: aView [
	<gtView>
	^ aView forward
		title: 'References';
		object: [ self class gtReferences & (#hasSubscriptionWithNonWeakActionTypesFor: gtImplementors not) ];
		view: #gtItemsFor:
]
