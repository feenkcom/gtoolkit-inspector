Extension { #name : #BlThemeableColor }

{ #category : #'*GToolkit-Inspector' }
BlThemeableColor >> gtColorComputationFor: aView [
	<gtView>
	^ aView forward
		title: 'Source';
		priority: 5;
		object: [ colorComputation ];
		view: #gtSourceCodeFor:
]
