Extension { #name : #RBProgramNode }

{ #category : #'*GToolkit-Inspector' }
RBProgramNode >> gtPropertiesFor: aView [
	<gtView>
	properties ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Properties';
		priority: 10;
		items: [ properties 
			ifNil: #() 
			ifNotNil: [ :aDictionary |
				aDictionary associations ] ];
		column: 'Key' item: #key;
		column: 'Value' item: #value weight: 3;
		column: 'Type' item: [ :anAssoc | anAssoc value class ] weight: 2;
		send: #value
]

{ #category : #'*GToolkit-Inspector' }
RBProgramNode >> gtSourceCodeFor: aView [
	<gtView>
	self methodNode ifNil: [ ^ aView empty ].
	^ aView textEditor
		title: 'Source code';
		actionButtonIcon: BrGlamorousVectorIcons browse
			tooltip: 'Browse'
			action: [ self methodNode compiledMethod gtBrowse ];
		aptitude: BrGlamorousCodeEditorAptitude;
		styler:
			(BrRBTextStyler new
				classOrMetaClass: self methodNode compiledMethod methodClass);
		text: [ | text |
			text := self source asRopedText.
			text
				attributes:
					{(BlTextUnderlineAttribute new
						color: BrGlamorousColors textHighlightColor;
						thickness: 3;
						beNotOverwritableByStyler)}
				from: self start
				to: self stop ]
]

{ #category : #'*GToolkit-Inspector' }
RBProgramNode >> gtTreeFor: aView [
	<gtView> 
	^ aView tree
		title: 'Tree';
		priority: 60;
		items: [ { self } ];
		children: #children;
		expandAll
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
