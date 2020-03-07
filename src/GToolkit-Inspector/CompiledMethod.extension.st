Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Inspector' }
CompiledMethod >> astNodesList [
	| verticalContainer nodesCollection |
	
	nodesCollection := self ast doSemanticAnalysis allChildren.
	 
	verticalContainer := BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent.
			c padding: (BlInsets all: 10)];
		layout: BlLinearLayout vertical.
		
	verticalContainer addChild: (BrLabel new
		text: ('Syntactical constructs:' asRopedText fontSize: 25);
		look: BrGlamorousLabelLook;
		margin: (BlInsets top: 10 right: 0 bottom: 15 left: 5)).
		
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBReturnNode ])
		ifTrue: [ verticalContainer addChild: (self explanationLabelFor: #ReturnNode) ]
		ifFalse: [ verticalContainer addChild: (self regularLabelFor: #ReturnNode) ].
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBPragmaNode ])
		ifTrue: [ verticalContainer addChild: (self explanationLabelFor: #PragmaNode) ]
		ifFalse: [ verticalContainer addChild: (self regularLabelFor: #PragmaNode) ].
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBArrayNode ])
		ifTrue: [ verticalContainer addChild: (self explanationLabelFor: #ArrayNode) ]
		ifFalse: [ verticalContainer addChild: (self regularLabelFor: #ArrayNode) ].
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBCascadeNode ])
		ifTrue: [ verticalContainer addChild: (self explanationLabelFor: #CascadeNode) ]
		ifFalse: [ verticalContainer addChild: (self regularLabelFor: #CascadeNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBMessageNode) and: [ aNode isUnary ] ])
		ifTrue: [ verticalContainer addChild: (self explanationLabelFor: #UnaryNode) ]
		ifFalse: [ verticalContainer addChild: (self regularLabelFor: #UnaryNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBMessageNode) and: [ aNode isBinary ] ])
		ifTrue: [ verticalContainer addChild: (self explanationLabelFor: #BinaryNode) ]
		ifFalse: [ verticalContainer addChild: (self regularLabelFor: #BinaryNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBMessageNode) and: [ aNode isKeyword ] ])
		ifTrue: [ verticalContainer addChild: (self explanationLabelFor: #KeywordNode) ]
		ifFalse: [ verticalContainer addChild: (self regularLabelFor: #KeywordNode) ].
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBBlockNode ])
		ifTrue: [ verticalContainer addChild: (self explanationLabelFor: #BlockNode) ]
		ifFalse: [ verticalContainer addChild: (self regularLabelFor: #BlockNode) ].
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBAssignmentNode ])
		ifTrue: [ verticalContainer addChild: (self explanationLabelFor: #AssignmentNode) ]
		ifFalse: [ verticalContainer addChild: (self regularLabelFor: #AssignmentNode) ].
	(nodesCollection anySatisfy: [ :aNode | ((aNode isKindOf: RBVariableNode) and: [ aNode isTemp ]) and: [ aNode isArg not ] ])
		ifTrue: [ verticalContainer addChild: (self explanationLabelFor: #TemporaryNode) ]
		ifFalse: [ verticalContainer addChild: (self regularLabelFor: #TemporaryNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBVariableNode) and: [ aNode isArg ] ])
		ifTrue: [ verticalContainer addChild: (self explanationLabelFor: #ArgumentNode) ]
		ifFalse: [ verticalContainer addChild: (self regularLabelFor: #ArgumentNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBVariableNode) and: [ aNode isGlobal ] ])
		ifTrue: [ verticalContainer addChild: (self explanationLabelFor: #GlobalNode) ]
		ifFalse: [ verticalContainer addChild: (self regularLabelFor: #GlobalNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBVariableNode) and: [ aNode isSelf ] ])
		ifTrue: [ verticalContainer addChild: (self explanationLabelFor: #SelfNode) ]
		ifFalse: [ verticalContainer addChild: (self regularLabelFor: #SelfNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBVariableNode) and: [ aNode isSuper ] ])
		ifTrue: [ verticalContainer addChild: (self explanationLabelFor: #SuperNode) ]
		ifFalse: [ verticalContainer addChild: (self regularLabelFor: #SuperNode) ].
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBLiteralValueNode ])
		ifTrue: [ verticalContainer addChild: (self explanationLabelFor: #LiteralValueNode) ]
		ifFalse: [ verticalContainer addChild: (self regularLabelFor: #LiteralValueNode) ].
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBLiteralArrayNode ])
		ifTrue: [ verticalContainer addChild: (self explanationLabelFor: #LiteralArrayNode) ]
		ifFalse: [ verticalContainer addChild: (self regularLabelFor: #LiteralArrayNode) ].

	^ verticalContainer
		width: 250.
]

{ #category : #'*GToolkit-Inspector' }
CompiledMethod >> explanationLabelFor: aNodeNameSymbol [
	| lines nodeName label |
	
	nodeName := aNodeNameSymbol asRopedText from: 1 to: (aNodeNameSymbol size - 4).
	lines := OrderedCollection new.
	
	label := BrLabel new
		clipChildren: false;
		layout: BlLinearLayout vertical;
		geometry: (BlRectangle cornerRadius: 4);
		padding: (BlInsets all: 5);
		margin: (BlInsets top: 0 right: 0 bottom: 5 left: 5);
		look: (BrInteractiveCommonLook new 
			default: [ :aWidget |
				lines do: [ :each | each removeFromParent ].
				lines removeAll.
				aWidget 
					border: (BlBorder paint: BrGlamorousColors textHighlightColor width: 2);
					background: Color transparent ];
			hovered: [ :aWidget |
				aWidget border: (BlBorder paint: BrGlamorousColors textHighlightColor width: 2).
				aWidget background: (BrGlamorousColors textHighlightColor alpha: 0.5).
				aWidget explainer firstExplanationHolderParent explainer
					allTargetChildrenWithModel: aWidget explainer model
					do: [ :explanationTargetElement | 
						lines add: (BlLineElement new
							fromAnchor:
								(BlNearestPositionTightCircleAnchor
									referenceElement: aWidget
									relatedTo: explanationTargetElement);
							toAnchor: (BlNearestPositionTightCircleAnchor
									referenceElement: explanationTargetElement
									relatedTo: aWidget);
							zIndex: 10;
							border: (BlBorder paint: (BrGlamorousColors textHighlightColor alpha: 0.7) width: 2);
							constraintsDo: [ :c | c ignoreByLayout ];
							yourself).
						aWidget 
							firstCommonParent: explanationTargetElement
							ifFound: [ :aCommonParent |
								aCommonParent addChild: (lines at: (lines size)) ]
							ifNone: [  ] ]  ] );
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ].
	label explainer
		isExplanation: true;
		model: aNodeNameSymbol.
	label addChildren: { BlTextElement new text: nodeName asRopedText }.
	
	^ label.
]

{ #category : #'*GToolkit-Inspector' }
CompiledMethod >> gtSourceFor: aView [
	<gtView>
	^ aView explicit
		title: 'Source';
		priority: 10;
		actionStencil: [ 
			BrButton new 
				look: BrGlamorousButtonWithIconLook;
				icon: BrGlamorousIcons browse asElement;
				action: [ self browse ] ];
		stencil: [ ((GtMethodCoder forMethod: self) expanded: true; asElement) asScrollableElement ]
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
		stencil: [ 
			| mainContainer verticalContainer coder coderElement |
			
			mainContainer := BlElement new
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent.
					c padding: (BlInsets all: 5)];
				layout: BlLinearLayout horizontal. 
			mainContainer explainer isExplanationHolder: true.
			verticalContainer := self astNodesList.
				
			coder := GtMethodCoder new forMethod: self.
			coder explanationLink: (self compositeExplanationLinkStylerRules).
			coderElement := (coder expanded: true) asElement margin: (BlInsets all: 10).
			coderElement forceLayout.
			coderElement vMatchParent.
			
			mainContainer addChild: verticalContainer.
			mainContainer addChild: coderElement.
			
			mainContainer.
			]
]

{ #category : #'*GToolkit-Inspector' }
CompiledMethod >> regularLabelFor: aNodeNameSymbol [
	| nodeName |
	
	nodeName := aNodeNameSymbol asRopedText from: 1 to: (aNodeNameSymbol size - 4).
	
	^ BrLabel new
		text: (nodeName asRopedText italic; foreground: Color gray);
		look: BrGlamorousLabelLook;
		padding: (BlInsets all: 5);
		margin: (BlInsets top: 0 right: 0 bottom: 5 left: 5).
		
]
