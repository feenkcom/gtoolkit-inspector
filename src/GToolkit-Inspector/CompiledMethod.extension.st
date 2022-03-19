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
		stencil: [ (GtPharoMethodCoder forMethod: self) asExpandedOnlyElement vFitContentLimited ]
]

{ #category : #'*GToolkit-Inspector' }
CompiledMethod >> gtTreeFor: aView [
	<gtView>
	^ self parseTree gtTreeFor: aView
]

{ #category : #'*GToolkit-Inspector' }
CompiledMethod >> gtViewNodesExplanationWithLinksFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Syntax Explanation' translated;
		stencil: [ GtPharoSyntaxExplainer new forMethod: self ].
]

{ #category : #'*GToolkit-Inspector' }
CompiledMethod >> gtViewPragmasFor: aView [
	<gtView>
	^ aView list
		title: 'Pragmas';
		items: [ self pragmas ]
]
