Extension { #name : #ClassVariable }

{ #category : #'*GToolkit-Inspector' }
ClassVariable >> gtReferencesFor: aView [
	<gtView>
	^ aView forward
		title: 'References';
		object: [ GtSearchClassVariableReferenceFilter
				forClassAndSubclasses: self owningClass
				andVariable: self name ];
		view: #gtItemsFor:
]
