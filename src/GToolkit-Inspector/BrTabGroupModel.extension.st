Extension { #name : #BrTabGroupModel }

{ #category : #'*GToolkit-Inspector' }
BrTabGroupModel >> gtTabsFor: aView [
	<gtView>
	
	^ aView list
		title: 'Tabs' translated;
		items: [ self tabs ]
]
