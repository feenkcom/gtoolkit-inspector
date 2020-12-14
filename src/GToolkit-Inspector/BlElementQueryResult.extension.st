Extension { #name : #BlElementQueryResult }

{ #category : #'*GToolkit-Inspector' }
BlElementQueryResult >> gtResultsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Result';
		priority: 10;
		items: [ results ];
		column: 'Icon' icon: [ :eachResult |
			eachResult isNotEmpty 
				ifTrue: [ 
					(GtInspectorAcceptIconStencil new 
						radius: 8; 
						thickness: 2) asElement 
						background: BrGlamorousColors successBackgroundColor ]
				ifFalse: [ 
					(GtInspectorPlusIconStencil close 
						radius: 8; 
						thickness: 2) asElement 
						background: BrGlamorousColors errorBackgroundColor] ]
			width: 35;
		column: 'Result' text: [ :eachResult | eachResult displayString ];
		column: 'Query' text: [ :eachResult | eachResult step displayString ]
]
