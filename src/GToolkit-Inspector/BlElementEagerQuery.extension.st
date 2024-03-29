Extension { #name : #BlElementEagerQuery }

{ #category : #'*GToolkit-Inspector' }
BlElementEagerQuery >> gtLastStepResultFor: aView [
	<gtView>
	result ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Last non-empty step results';
		priority: 20;
		object: [ result ];
		view: #gtLastStepResultFor:
]

{ #category : #'*GToolkit-Inspector' }
BlElementEagerQuery >> gtResultsFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Result';
		priority: 10;
		object: [ result ];
		view: #gtResultsFor:
]
