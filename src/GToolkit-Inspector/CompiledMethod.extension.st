Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Inspector' }
CompiledMethod >> gtSourceFor: aView [
	<gtView>
	^ aView explicit
		title: 'Source';
		priority: 10;
		actionButtonIcon: BrGlamorousVectorIcons browse
			tooltip: 'Browse method'
			action: [ self gtBrowse ];
		stencil: [ (GtMethodCoder forMethod: self) asExpandedOnlyElement vFitContentLimited ]
]

{ #category : #'*GToolkit-Inspector' }
CompiledMethod >> gtTreeFor: aView [
	^ self parseTree gtTreeFor: aView
]

{ #category : #'*GToolkit-Inspector' }
CompiledMethod >> gtViewNodesExplanationWithLinksFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Syntax Explanation' translated;
		stencil: [ GtSyntaxExplanationViewUtility new forMethod: self ].
]
