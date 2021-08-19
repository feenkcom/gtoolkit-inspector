Extension { #name : 'BlEventTraversalStep' }

{ #category : '*GToolkit-Inspector' }
BlEventTraversalStep >> gtTargetFor: aView [
	<gtView>
	(self target isKindOf: BlElement) 
		ifTrue: [^ self target gtPreviewFor: aView].
	(self target isKindOf: BrActor) 
		ifTrue: [ self target widgetDo: [ :aWidget | 
				^ aWidget gtPreviewFor: aView ] ].
	^ aView empty
	
]
