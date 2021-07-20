Extension { #name : 'BlTextParagraphSegment' }

{ #category : '*GToolkit-Inspector' }
BlTextParagraphSegment >> gtMetricsFor: aView [
	<gtView>

	^ (self metrics gtItemsFor: aView)
			title: 'Metrics'
]
