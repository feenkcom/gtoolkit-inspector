Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Inspector' }
CompiledMethod >> gtPropertiesFor: aView [ 
	<gtView>
	self hasProperties ifFalse: [^ aView empty ].
	^ aView columnedList 
		title: 'Properties';
		priority: 11;
		items: [ self properties properties associations ];
		column: 'Property' text: #key;
		column: 'Value' text: #value;
		contextItemLabel: 'Remove property'
			action: [ :aWidget :anAssoc | 
				self removeProperty: anAssoc key.
				aWidget phlow firstParentWithView phlow update ];
		send: #value;
		actionUpdateButton
]

{ #category : #'*GToolkit-Inspector' }
CompiledMethod >> gtSourceCodeFor: aView [
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
CompiledMethod >> gtSourceFor: aView [
	^ self gtSourceCodeFor: aView
]

{ #category : #'*GToolkit-Inspector' }
CompiledMethod >> gtSpecificSizeInMemory [
	^ super gtSpecificSizeInMemory  +
		(self penultimateLiteral isMethodProperties
			ifTrue: [ self penultimateLiteral sizeInMemory ] 
			ifFalse: [ 0 ])
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
		title: 'Syntax explanation' translated;
		stencil: [ GtPharoSyntaxExplainer new forMethod: self ].
]

{ #category : #'*GToolkit-Inspector' }
CompiledMethod >> gtViewPragmasFor: aView [
	<gtView>
	^ aView list
		title: 'Pragmas';
		items: [ self pragmas ]
]
