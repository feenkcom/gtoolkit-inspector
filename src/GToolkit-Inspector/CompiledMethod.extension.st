Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Inspector' }
CompiledMethod >> gtPropertiesFor: aView [ 
	<gtView>
	self hasProperties ifFalse: [^ aView empty ].
	^ aView columnedList 
		title: 'Properties';
		priority: 40;
		items: [ self properties properties associations ];
		column: 'Property' text: #key;
		column: 'Value' text: #value;
		contextItemLabel: 'Remove property'
			action: [ :aWidget :anAssoc | 
				self removeProperty: anAssoc key.
				aWidget phlow firstParentWithViewContent phlow update ];
		send: #value;
		actionUpdateButton
]

{ #category : #'*GToolkit-Inspector' }
CompiledMethod >> gtSourceCodeFor: aView [
	<gtView>
	^ aView explicit
		title: 'Source';
		priority: 5;
		actionButtonIcon: BrGlamorousVectorIcons browse 
			tooltip: 'Browse method'
			action: [ :aButton | aButton phlow spawnTool: 
				(GtMethodCoderTool compiledMethod: self method) ];
		stencil: [ 
			 (((GtPharoMethodCoder forMethod: self) asCoderViewModel)
					withHeader;
					expanded: true;
					asExpandedOnlyElement) vFitContentLimited ].
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
		priority: 35;
		stencil: [ GtPharoSyntaxExplainer new forMethod: self ].
]

{ #category : #'*GToolkit-Inspector' }
CompiledMethod >> gtViewPragmasFor: aView [
	<gtView>
	^ aView list
		title: 'Pragmas';
		priority: 29;
		items: [ self pragmas ]
]
