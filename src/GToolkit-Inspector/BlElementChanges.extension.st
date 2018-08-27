Extension { #name : #BlElementChanges }

{ #category : #'*GToolkit-Inspector' }
BlElementChanges >> gtItemsFor: aView [
	<gtView> 
	
	^ (self changes flatCollect:  [ :each | each records ]) gtItemsFor: aView.
	"	composite tree 
		title: 'Changes' translated;
		rootsExpanded;
		display: [ self changes select: [ :each | each records isNotEmpty ] ];
		children: [ :each | (each isKindOf: BlElementChange)
				ifTrue: [ each records ]
				ifFalse: [ {  } ] ]"
]
