Extension { #name : #GtSyntaxExplanationViewUtility }

{ #category : #'*GToolkit-Inspector' }
GtSyntaxExplanationViewUtility class >> explanationLabelFor: aNodeNameSymbol [
	| lines nodeName label |
	
	nodeName := aNodeNameSymbol asRopedText from: 1 to: (aNodeNameSymbol size - 4).
	lines := OrderedCollection new.
	
	label := BrLabel new
		clipChildren: false;
		layout: BlLinearLayout vertical;
		geometry: (BlRectangle cornerRadius: 4);
		padding: (BlInsets all: 5);
		margin: (BlInsets top: 5 right: 0 bottom: 5 left: 5);
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
	label addChildren: { BlTextElement new text: nodeName asRopedText glamorousRegularFont }.
	
	^ label.
]

{ #category : #'*GToolkit-Inspector' }
GtSyntaxExplanationViewUtility class >> gtAstNodesList [
	| verticalContainer nodesCollection |
	
	nodesCollection := method ast doSemanticAnalysis allChildren.
	 
	verticalContainer := BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent.
			c padding: (BlInsets all: 10)];
		layout: BlLinearLayout vertical;
		background: Color white;
		look: BrShadowLook.
		
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBReturnNode ])
		ifTrue: [ verticalContainer addChild: (self gtExplanationLabelFor: #ReturnNode) ]
		ifFalse: [ verticalContainer addChild: (self gtRegularLabelFor: #ReturnNode) ].
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBPragmaNode ])
		ifTrue: [ verticalContainer addChild: (self gtExplanationLabelFor: #PragmaNode) ]
		ifFalse: [ verticalContainer addChild: (self gtRegularLabelFor: #PragmaNode) ].
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBArrayNode ])
		ifTrue: [ verticalContainer addChild: (self gtExplanationLabelFor: #ArrayNode) ]
		ifFalse: [ verticalContainer addChild: (self gtRegularLabelFor: #ArrayNode) ].
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBCascadeNode ])
		ifTrue: [ verticalContainer addChild: (self gtExplanationLabelFor: #CascadeNode) ]
		ifFalse: [ verticalContainer addChild: (self gtRegularLabelFor: #CascadeNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBMessageNode) and: [ aNode isUnary ] ])
		ifTrue: [ verticalContainer addChild: (self gtExplanationLabelFor: #UnaryNode) ]
		ifFalse: [ verticalContainer addChild: (self gtRegularLabelFor: #UnaryNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBMessageNode) and: [ aNode isBinary ] ])
		ifTrue: [ verticalContainer addChild: (self gtExplanationLabelFor: #BinaryNode) ]
		ifFalse: [ verticalContainer addChild: (self gtRegularLabelFor: #BinaryNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBMessageNode) and: [ aNode isKeyword ] ])
		ifTrue: [ verticalContainer addChild: (self gtExplanationLabelFor: #KeywordNode) ]
		ifFalse: [ verticalContainer addChild: (self gtRegularLabelFor: #KeywordNode) ].
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBBlockNode ])
		ifTrue: [ verticalContainer addChild: (self gtExplanationLabelFor: #BlockNode) ]
		ifFalse: [ verticalContainer addChild: (self gtRegularLabelFor: #BlockNode) ].
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBAssignmentNode ])
		ifTrue: [ verticalContainer addChild: (self gtExplanationLabelFor: #AssignmentNode) ]
		ifFalse: [ verticalContainer addChild: (self gtRegularLabelFor: #AssignmentNode) ].
	(nodesCollection anySatisfy: [ :aNode | ((aNode isKindOf: RBVariableNode) and: [ aNode isTemp ]) and: [ aNode isArg not ] ])
		ifTrue: [ verticalContainer addChild: (self gtExplanationLabelFor: #TemporaryNode) ]
		ifFalse: [ verticalContainer addChild: (self gtRegularLabelFor: #TemporaryNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBVariableNode) and: [ aNode isArg ] ])
		ifTrue: [ verticalContainer addChild: (self gtExplanationLabelFor: #ArgumentNode) ]
		ifFalse: [ verticalContainer addChild: (self gtRegularLabelFor: #ArgumentNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBVariableNode) and: [ aNode isGlobal ] ])
		ifTrue: [ verticalContainer addChild: (self gtExplanationLabelFor: #GlobalNode) ]
		ifFalse: [ verticalContainer addChild: (self gtRegularLabelFor: #GlobalNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBVariableNode) and: [ aNode isSelf ] ])
		ifTrue: [ verticalContainer addChild: (self gtExplanationLabelFor: #SelfNode) ]
		ifFalse: [ verticalContainer addChild: (self gtRegularLabelFor: #SelfNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBVariableNode) and: [ aNode isSuper ] ])
		ifTrue: [ verticalContainer addChild: (self gtExplanationLabelFor: #SuperNode) ]
		ifFalse: [ verticalContainer addChild: (self gtRegularLabelFor: #SuperNode) ].
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBLiteralValueNode ])
		ifTrue: [ verticalContainer addChild: (self gtExplanationLabelFor: #LiteralValueNode) ]
		ifFalse: [ verticalContainer addChild: (self gtRegularLabelFor: #LiteralValueNode) ].
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBLiteralArrayNode ])
		ifTrue: [ verticalContainer addChild: (self gtExplanationLabelFor: #LiteralArrayNode) ]
		ifFalse: [ verticalContainer addChild: (self gtRegularLabelFor: #LiteralArrayNode) ].

	^ verticalContainer
		width: 250.
]

{ #category : #'*GToolkit-Inspector' }
GtSyntaxExplanationViewUtility class >> gtCompositeExplanationLinkStylerRules [
	| compositeExplanationLinkStylerRules |
	
	compositeExplanationLinkStylerRules := GtCompositeExplanationLinkStyler forLinks:
		{
			GtASTNodeStylerRule new
				nodeClassName: #RBPragmaNode;
				styleBlock: [ :aNode :aText |
					(aText
						from: aNode start - 1
						to: aNode start - 1)
						attributes: { GtZeroSizeCircleExplanationTextAdornment forIdentifier: #PragmaNode } ].
			GtASTNodeStylerRule new
				nodeClassName: #RBReturnNode;
				styleBlock: [ :aNode :aText |
					(aText
						from: aNode start - 1
						to: aNode start - 1)
						attributes: { GtZeroSizeCircleExplanationTextAdornment forIdentifier: #ReturnNode } ].
			"GtASTNodeStylerRule new
				nodeClassName: #RBMethodNode;
				styleBlock: [ :aNode :aText |
					(aText
						from: aNode start - 1
						to: aNode start - 1)
						attributes: { GtYellowCircleExplanationTextAdornment forIdentifier: #MethodNode } ]."
			GtASTNodeStylerRule new
				nodeClassName: #RBCascadeNode;
				styleBlock: [ :aNode :aText |
					aNode semicolons do: [ :each |
						(aText
							from: each - 1
							to: each - 1)
							attributes: {GtZeroSizeCircleExplanationTextAdornment forIdentifier: #CascadeNode}] ].
			GtASTNodeStylerRule new
				nodeClassName: #RBArrayNode;
				styleBlock: [ :aNode :aText |
					(aText
						from: aNode left - 1
						to: aNode left - 1)
						attributes: { GtZeroSizeCircleExplanationTextAdornment forIdentifier: #ArrayNode } ].
			GtASTNodeStylerRule new
				nodeClassName: #RBMessageNode;
				styleBlock: [ :aNode :aText |
					| identifier |
					(aNode isBinary) ifTrue: [ identifier := #BinaryNode ].
					(aNode isUnary) ifTrue: [ identifier := #UnaryNode ].
					(aNode isKeyword) ifTrue: [ identifier := #KeywordNode ].
					(aText
						from: aNode keywordsPositions first - 1
						to: aNode keywordsPositions first - 1)
						attributes: { GtZeroSizeCircleExplanationTextAdornment forIdentifier: identifier } ].
			GtASTNodeStylerRule new
				nodeClassName: #RBBlockNode;
				styleBlock: [ :aNode :aText |
					(aText
						from: aNode left - 1
						to: aNode left - 1)
						attributes: { GtZeroSizeCircleExplanationTextAdornment forIdentifier: #BlockNode } ].
			GtASTNodeStylerRule new
				nodeClassName: #RBAssignmentNode;
				styleBlock: [ :aNode :aText |
					(aText
						from: aNode assignment - 1
						to: aNode assignment - 1)
						attributes: { GtZeroSizeCircleExplanationTextAdornment forIdentifier: #AssignmentNode } ].
			GtASTNodeStylerRule new
				nodeClassName: #RBVariableNode;
				styleBlock: [ :aNode :aText |
					| identifier |
					(aNode isTemp) ifTrue: [ identifier := #TemporaryNode ].
					(aNode isArg) ifTrue: [ identifier := #ArgumentNode ].
					(aNode isGlobal) ifTrue: [ identifier := #GlobalNode ].
					(aNode isSelf) ifTrue: [ identifier := #SelfNode ].
					(aNode isSuper) ifTrue: [ identifier := #SuperNode ].
					(aText
						from: aNode start - 1
						to: aNode start - 1)
						attributes: { GtZeroSizeCircleExplanationTextAdornment forIdentifier: identifier } ].
			GtASTNodeStylerRule new
				nodeClassName: #RBLiteralValueNode;
				styleBlock: [ :aNode :aText |
					(aText
						from: aNode start - 1
						to: aNode start - 1)
						attributes: {GtZeroSizeCircleExplanationTextAdornment forIdentifier: #LiteralValueNode} ].
			GtASTNodeStylerRule new
				nodeClassName: #RBLiteralArrayNode;
				styleBlock: [ :aNode :aText |
					(aText
						from: aNode start - 1
						to: aNode start - 1)
						attributes: {GtZeroSizeCircleExplanationTextAdornment forIdentifier: #LiteralArrayNode} ].
		}.
	
	^ compositeExplanationLinkStylerRules.
]

{ #category : #'*GToolkit-Inspector' }
GtSyntaxExplanationViewUtility class >> gtRegularLabelFor: aNodeNameSymbol [
	| nodeName |
	
	nodeName := aNodeNameSymbol asRopedText from: 1 to: (aNodeNameSymbol size - 4).
	
	^ BrLabel new
		text: (nodeName asRopedText glamorousRegularFont; foreground: Color gray);
		look: BrGlamorousLabelLook;
		padding: (BlInsets all: 5);
		margin: (BlInsets top: 0 right: 0 bottom: 5 left: 5).
		
]
