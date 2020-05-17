Extension { #name : #RBProgramNode }

{ #category : #'*GToolkit-Inspector' }
RBProgramNode >> gtSourceCodeFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Source code';
		actionButtonIcon: BrGlamorousVectorIcons browse 
			label: 'Browse'
			action: [ self methodNode compiledMethod browse ];
		look: BrGlamorousCodeEditorLook new;
		styler: (BrRBTextStyler new classOrMetaClass: self methodNode compiledMethod methodClass);
		text: [ 
			| text |
			text := self source asRopedText.
			text 
				attributes: {
					BlTextHighlightAttribute new 
						paint: (BrGlamorousColors lightBorderColor alpha: 0.5); 
						beNotOverwritableByStyler} 
				from: self start 
				to: self stop.
		]
]

{ #category : #'*GToolkit-Inspector' }
RBProgramNode >> gtTreeFor: aView [
	<gtView> 
	^ aView tree
		title: 'Tree';
		priority: 60;
		items: [ { self } ];
		children: #children
]

{ #category : #'*GToolkit-Inspector' }
RBProgramNode >> gtVisualTreeFor: aView [
	<gtView> 
	| wrapperFactory |	
	wrapperFactory := RBNodeWrapperFactory new. 
	^ aView mondrian
		title: 'Map';
		priority: 60;
		painting: [ :view | 
			view nodes 
				shape: [ :each |
					| textElement text |
					text := BlRopedText string: ((each printString) truncateTo:30).
					textElement := BlTextElement new.
					textElement text: text.
					textElement 	
						when: BlClickEvent 
						do: [ :e | 
							textElement phlow spawnObject: each node.
							e consumed: true ].
					textElement ];	
				with: ((self withDeepCollect: #children) collect: [ :each | wrapperFactory wrapperFor: each ]).
			view edges connectFrom: #parent.
			view layout tree ].
]
