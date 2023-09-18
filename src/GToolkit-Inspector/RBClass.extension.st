Extension { #name : #RBClass }

{ #category : #'*GToolkit-Inspector' }
RBClass >> gtDefinitionFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Definition';
		priority: 2;
		styler: (BrRBTextStyler new
				   isForWorkspace: true;
				   yourself);
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ self gtDefinitionString ]
]

{ #category : #'*GToolkit-Inspector' }
RBClass >> gtMethodsFor: aView [ 
	<gtView>
	^ aView columnedList
		title: 'Methods';
		priority: 1;
		items: [ (self newMethods values collect: [:m | 'New' -> m]), (self removedMethods collect: [:m | 'Removed' -> m ]) ];
		column: 'Status' text: [:each | each key ];
		column: 'Method' text: [:each | each value selector ]
]
