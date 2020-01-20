Extension { #name : #BlElementChanges }

{ #category : #'*GToolkit-Inspector' }
BlElementChanges >> gtItemsFor: aView [
	<gtView> 
	^ aView forward
		title: 'Changes';
		object: [ self changes flatCollect:  [ :each | each records ] ];
		view: #gtItemsFor:.
]
