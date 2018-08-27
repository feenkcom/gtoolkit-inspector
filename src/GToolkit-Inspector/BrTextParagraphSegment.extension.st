Extension { #name : #BrTextParagraphSegment }

{ #category : #'*GToolkit-Inspector' }
BrTextParagraphSegment >> gtMetricsFor: aView [
	<gtView>

	^ (self metrics gtItemsFor: aView)
			title: 'Metrics'
]
