Extension { #name : 'BlElementEagerQuery' }

{ #category : '*GToolkit-Inspector' }
BlElementEagerQuery >> gtResultsFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Result';
		priority: 10;
		object: [ result ];
		view: #gtResultsFor:
]
