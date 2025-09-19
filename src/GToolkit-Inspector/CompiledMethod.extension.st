Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Inspector' }
CompiledMethod >> gtMethodCodersFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Method coders';
		priority: 20;
		items: [ ((GtPhlowCollector new
				fromObject: self;
				pragmaName: #gtMethodCoder:;
				collectAllPragmas)
				sorted: [ :a :b | a arguments first > b arguments first ])
				collect: [ :each | each -> (self perform: each methodSelector) ] ];
		column: 'Definition' text: [ :each | each key methodSelector ];
		column: 'Priority' text: [ :each | each key arguments first ];
		column: 'Active' text: [ :each | each value notNil ];
		column: 'Coder type' text: [ :each | each value ifNil: [ '' ] ifNotNil: [:class | class name ] ];
		send: #key
]

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
			self isBigMethod
				ifTrue: [ 
					BrEditor new
						aptitude: BrGlamorousCodeEditorAptitude new;
						beReadOnlyWithSelection;
						text: ((self sourceCode first: 10000) , '...') ]
				ifFalse: [

					(((GtPharoMethodCoder forMethod: self) asCoderViewModel)
						withHeader;
						expanded: true;
						asExpandedOnlyElement) vFitContentLimited ] ].
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
