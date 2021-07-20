Extension { #name : 'GtResourcesUtility' }

{ #category : '*GToolkit-Inspector' }
GtResourcesUtility >> gtLocationsFor: aView [
	<gtView>
	self locations ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Locations';
		items: [ self locations ];
		column: 'Name' item: [ :aLocation | aLocation printString ];
		column: 'Exists' 
			item: [ :aLocation | aLocation exists 
				ifTrue: [ 'available' asRopedText foreground: BrGlamorousColors successBackgroundColor ] 
				ifFalse: [ 'unavailable' asRopedText foreground: BrGlamorousColors errorBackgroundColor ] ] 
			width: 100
]
