Extension { #name : #RBAbstractClass }

{ #category : #'*GToolkit-Inspector' }
RBAbstractClass >> gtMethodsFor: aView [ 
	<gtView>
	^ aView columnedList
		title: 'Methods';
		priority: 1;
		items: [ (self newMethods values collect: [:m | 'New' -> m]), (self removedMethods collect: [:m | 'Removed' -> m ]) ];
		column: 'Status' text: [:each | each key ];
		column: 'Method' text: [:each | each value selector ]
]
