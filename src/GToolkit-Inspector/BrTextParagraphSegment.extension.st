Extension { #name : #BrTextParagraphSegment }

{ #category : #'*GToolkit-Inspector' }
BrTextParagraphSegment >> gtMetricsFor: aView [
	<gtView: 2>

	^ (self metrics gtItemsFor: aView)
			title: 'Metrics'
]
