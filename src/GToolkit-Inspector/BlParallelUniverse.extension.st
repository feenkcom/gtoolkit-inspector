Extension { #name : #BlParallelUniverse }

{ #category : #'*GToolkit-Inspector' }
BlParallelUniverse >> gtSpacesFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Spaces';
		priority: 10;
		items: [ self spaces ];
		column: 'Index' text: [ :eachSpace :anIndex | anIndex ] width: 50;
		column: 'Name' text: [ :eachSpace | eachSpace ifNotNil: #title ifNil: 'nil' ];
		actionButtonIcon: BrGlamorousIcons trash 
			action: [
				self spaces do: #close.
				self tryToRunDeferredActions.
				self markAsNotPulsing ]
]
