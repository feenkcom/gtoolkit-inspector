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

{ #category : #'*GToolkit-Inspector' }
BlThemeableColor >> iconOrThumbnailOfSize: aNumberOrPoint [
	"Answer an appropiate form to represent the receiver"

	^ color iconOrThumbnailOfSize: aNumberOrPoint
]
