Extension { #name : 'BlShortcutRegistry' }

{ #category : '*GToolkit-Inspector' }
BlShortcutRegistry >> gtItemsFor: aView [
	<gtView>
	self shortcuts ifEmpty: [ ^ aView empty ].
	^ aView columnedList
		title: 'Shortcuts' translated;
		priority: 10;
		items: [ self shortcuts asArray ];
		column: 'Name' text: [ :each | each name ifNil: [ each gtDisplayString ] ];
		column: 'Combination' text: [ :each | each combinationForPlatform gtDisplayString ]
]
