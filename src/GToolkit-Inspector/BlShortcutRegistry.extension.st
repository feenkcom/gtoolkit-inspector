Extension { #name : #BlShortcutRegistry }

{ #category : #'*GToolkit-Inspector' }
BlShortcutRegistry >> gtItemsFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Shortcuts' translated;
		priority: 10;
		items: [ self shortcuts asArray ];
		column: 'Key' item: [ :each | each combination gtDisplayString ];
		column: 'Action' item: [ :each | each action asString ]
]
