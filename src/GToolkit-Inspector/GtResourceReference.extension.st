Extension { #name : #GtResourceReference }

{ #category : #'*GToolkit-Inspector' }
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
