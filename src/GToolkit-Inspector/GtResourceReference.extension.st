Extension { #name : 'GtResourceReference' }

{ #category : '*GToolkit-Inspector' }
GtResourceReference >> gtInspectFileReferenceFor: aView [
	<gtAction>
	^ aView button
		label: 'File';
		icon: BrGlamorousVectorIcons inspect;
		tooltip: 'Inspect File Reference';
		priority: 10;
		action: [ :aButton | aButton phlow spawnObject: self fileReference ]
]

{ #category : '*GToolkit-Inspector' }
GtResourceReference >> gtItemsFor: aView [
	<gtView>
	self exists ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'Items';
		priority: 5;
		object: [ self fileReference ];
		view: #gtItemsFor:
]

{ #category : '*GToolkit-Inspector' }
GtResourceReference >> gtLocationsFor: aView [
	<gtView>
	self path ifNil: [ ^ aView empty ].
	^ aView columnedList 
		title: 'Locations';
		items: [ self results ];
		column: 'Name' item: [ :aLocation | aLocation printString ];
		column: 'Exists'
			item: [ :aLocation | aLocation exists 
				ifTrue: [ 'available' asRopedText foreground: BrGlamorousColors successBackgroundColor ] 
				ifFalse: [ 'unavailable' asRopedText foreground: BrGlamorousColors errorBackgroundColor ] ] 
			width: 100
]

{ #category : '*GToolkit-Inspector' }
GtResourceReference >> gtPathFor: aView [
	<gtView>
	^ aView forward
		title: 'Path';
		priority: 10;
		object: [ self fileReference ];
		view: #gtPathFor:
]
