Extension { #name : #Archive }

{ #category : #'*GToolkit-Inspector' }
Archive >> gtMembersFor: aView [
	<gtView>
	^ aView list 
		title: 'Members';
		items: [ self members ]
]
