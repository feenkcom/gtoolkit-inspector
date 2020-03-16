Extension { #name : #GtSyntaxExplanationViewUtility }

{ #category : #'*GToolkit-Inspector' }
GtSyntaxExplanationViewUtility >> gtAstNodesList [
	| verticalContainer nodesCollection messageNodesGroup variableNodesGroup arrayNodesGroup literalValueNodesGroup otherNodesGroup |
	
	nodesCollection := method ast doSemanticAnalysis allChildren.
	 
	verticalContainer := BlElement new
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ];
		layout: BlLinearLayout vertical;
		padding: (BlInsets all: 10).
	
	otherNodesGroup := self gtVerticalGroupElement.
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBPragmaNode ])
		ifTrue: [ otherNodesGroup addChild: (self gtExplanationLabelFor: #PragmaNode) ]
		ifFalse: [ otherNodesGroup addChild: (self gtRegularLabelFor: #PragmaNode) ].
	
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBReturnNode ])
		ifTrue: [ otherNodesGroup addChild: (self gtExplanationLabelFor: #ReturnNode) ]
		ifFalse: [ otherNodesGroup addChild: (self gtRegularLabelFor: #ReturnNode) ].
	
	messageNodesGroup := self gtVerticalGroupElement.
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBMessageNode) and: [ aNode isUnary ] ])
		ifTrue: [ messageNodesGroup addChild: (self gtExplanationLabelFor: #UnaryNode) ]
		ifFalse: [ messageNodesGroup addChild: (self gtRegularLabelFor: #UnaryNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBMessageNode) and: [ aNode isBinary ] ])
		ifTrue: [ messageNodesGroup addChild: (self gtExplanationLabelFor: #BinaryNode) ]
		ifFalse: [ messageNodesGroup addChild: (self gtRegularLabelFor: #BinaryNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBMessageNode) and: [ aNode isKeyword ] ])
		ifTrue: [ messageNodesGroup addChild: (self gtExplanationLabelFor: #KeywordNode) ]
		ifFalse: [ messageNodesGroup addChild: (self gtRegularLabelFor: #KeywordNode) ].
	
	variableNodesGroup := self gtVerticalGroupElement.
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBVariableNode) and: [ aNode isTemp and: [ aNode isArg not ] ] ])
		ifTrue: [ variableNodesGroup addChild: (self gtExplanationLabelFor: #TemporaryNode) ]
		ifFalse: [ variableNodesGroup addChild: (self gtRegularLabelFor: #TemporaryNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBVariableNode) and: [ aNode isArg ] ])
		ifTrue: [ variableNodesGroup addChild: (self gtExplanationLabelFor: #ArgumentNode) ]
		ifFalse: [ variableNodesGroup addChild: (self gtRegularLabelFor: #ArgumentNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBVariableNode) and: [ aNode isGlobal ] ])
		ifTrue: [ variableNodesGroup addChild: (self gtExplanationLabelFor: #GlobalNode) ]
		ifFalse: [ variableNodesGroup addChild: (self gtRegularLabelFor: #GlobalNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBVariableNode) and: [ aNode isSelf ] ])
		ifTrue: [ variableNodesGroup addChild: (self gtExplanationLabelFor: #SelfNode) ]
		ifFalse: [ variableNodesGroup addChild: (self gtRegularLabelFor: #SelfNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBVariableNode) and: [ aNode isSuper ] ])
		ifTrue: [ variableNodesGroup addChild: (self gtExplanationLabelFor: #SuperNode) ]
		ifFalse: [ variableNodesGroup addChild: (self gtRegularLabelFor: #SuperNode) ].
	
	arrayNodesGroup := self gtVerticalGroupElement.
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBArrayNode ])
		ifTrue: [ arrayNodesGroup addChild: (self gtExplanationLabelFor: #ArrayNode) ]
		ifFalse: [ arrayNodesGroup addChild: (self gtRegularLabelFor: #ArrayNode) ].
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBLiteralArrayNode ])
		ifTrue: [ arrayNodesGroup addChild: (self gtExplanationLabelFor: #LiteralArrayNode) ]
		ifFalse: [ arrayNodesGroup addChild: (self gtRegularLabelFor: #LiteralArrayNode) ].
	
	literalValueNodesGroup := self gtVerticalGroupElement.
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBLiteralValueNode) and: [aNode value isInteger]])
		ifTrue: [ literalValueNodesGroup addChild: (self gtExplanationLabelFor: #IntegerNode) ]
		ifFalse: [ literalValueNodesGroup addChild: (self gtRegularLabelFor: #IntegerNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBLiteralValueNode) and: [ aNode value isFloat]])
		ifTrue: [ literalValueNodesGroup addChild: (self gtExplanationLabelFor: #FloatNode) ]
		ifFalse: [ literalValueNodesGroup addChild: (self gtRegularLabelFor: #FloatNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBLiteralValueNode) and: [ aNode value isCharacter]])
		ifTrue: [ literalValueNodesGroup addChild: (self gtExplanationLabelFor: #CharacterNode) ]
		ifFalse: [ literalValueNodesGroup addChild: (self gtRegularLabelFor: #CharacterNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBLiteralValueNode) and: [ aNode value isSymbol]])
		ifTrue: [ literalValueNodesGroup addChild: (self gtExplanationLabelFor: #SymbolNode) ]
		ifFalse: [ literalValueNodesGroup addChild: (self gtRegularLabelFor: #SymbolNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBLiteralValueNode) and: [ aNode value isString and: [ aNode value isSymbol not]]])
		ifTrue: [ literalValueNodesGroup addChild: (self gtExplanationLabelFor: #StringNode) ]
		ifFalse: [ literalValueNodesGroup addChild: (self gtRegularLabelFor: #StringNode) ].
	
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBBlockNode ])
		ifTrue: [ otherNodesGroup addChild: (self gtExplanationLabelFor: #BlockNode) ]
		ifFalse: [ otherNodesGroup addChild: (self gtRegularLabelFor: #BlockNode) ].
	
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBAssignmentNode ])
		ifTrue: [ otherNodesGroup addChild: (self gtExplanationLabelFor: #AssignmentNode) ]
		ifFalse: [ otherNodesGroup addChild: (self gtRegularLabelFor: #AssignmentNode) ].
	
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBCascadeNode ])
		ifTrue: [ otherNodesGroup addChild: (self gtExplanationLabelFor: #CascadeNode) ]
		ifFalse: [ otherNodesGroup addChild: (self gtRegularLabelFor: #CascadeNode) ].
	
	(nodesCollection anySatisfy: [ :aNode | aNode comments notEmpty ])
		ifTrue: [ otherNodesGroup addChild: (self gtExplanationLabelFor: #CommentNode) ]
		ifFalse: [ otherNodesGroup addChild: (self gtRegularLabelFor: #CommentNode) ].
	
	
	verticalContainer addChildren: { 
		self gtHorizontalGroupElement addChildren: {
			self gtGroupLabelWithText: 'Messages'.
			self gtDividerBarElement.
			messageNodesGroup}.
		self gtHorizontalGroupElement addChildren: {
			self gtGroupLabelWithText: 'Variables'.
			self gtDividerBarElement.
			variableNodesGroup}.
		self gtHorizontalGroupElement addChildren: {
			self gtGroupLabelWithText: 'Arrays'.
			self gtDividerBarElement.
			arrayNodesGroup}.
		self gtHorizontalGroupElement addChildren: {
			self gtGroupLabelWithText: 'Literals'.
			self gtDividerBarElement.
			literalValueNodesGroup}.
		self gtHorizontalGroupElement addChildren: {
			self gtGroupLabelWithText: 'Others'.
			self gtDividerBarElement.
			otherNodesGroup}}.

	^ verticalContainer asScrollableElement 
		constraintsDo: [:c | c horizontal fitContent. c vertical matchParent.];
		background: Color white;
		look: BrShadowLook";
		margin: (BlInsets all: 10)"
]

{ #category : #'*GToolkit-Inspector' }
GtSyntaxExplanationViewUtility >> gtCompositeExplanationLinkStylerRules [
	| compositeExplanationLinkStylerRules |
	
	compositeExplanationLinkStylerRules := GtCompositeExplanationLinkStyler forLinks:
		{
			GtASTNodeStylerRule new
				nodeClassName: #RBProgramNode;
				styleBlock: [ :aNode :aText |
					aNode comments do: [:aCommentNode | 
					(aText
						from: aCommentNode start - 1
						to: aCommentNode start - 1)
						attributes: { GtYellowCircleExplanationTextAdornment forIdentifier: #CommentNode withSize: 0} ] ].
			GtASTNodeStylerRule new
				nodeClassName: #RBPragmaNode;
				styleBlock: [ :aNode :aText |
					(aText
						from: aNode start - 1
						to: aNode start - 1)
						attributes: { GtYellowCircleExplanationTextAdornment forIdentifier: #PragmaNode withSize: 0} ].
			GtASTNodeStylerRule new
				nodeClassName: #RBReturnNode;
				styleBlock: [ :aNode :aText |
					(aText
						from: aNode start - 1
						to: aNode start - 1)
						attributes: { GtYellowCircleExplanationTextAdornment forIdentifier: #ReturnNode withSize: 0} ].
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
							attributes: {GtYellowCircleExplanationTextAdornment forIdentifier: #CascadeNode withSize: 0}] ].
			GtASTNodeStylerRule new
				nodeClassName: #RBArrayNode;
				styleBlock: [ :aNode :aText |
					(aText
						from: aNode left - 1
						to: aNode left - 1)
						attributes: { GtYellowCircleExplanationTextAdornment forIdentifier: #ArrayNode withSize: 0} ].
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
						attributes: { GtYellowCircleExplanationTextAdornment forIdentifier: identifier withSize: 0} ].
			GtASTNodeStylerRule new
				nodeClassName: #RBBlockNode;
				styleBlock: [ :aNode :aText |
					(aText
						from: aNode left - 1
						to: aNode left - 1)
						attributes: { GtYellowCircleExplanationTextAdornment forIdentifier: #BlockNode withSize: 0} ].
			GtASTNodeStylerRule new
				nodeClassName: #RBAssignmentNode;
				styleBlock: [ :aNode :aText |
					(aText
						from: aNode assignment - 1
						to: aNode assignment - 1)
						attributes: { GtYellowCircleExplanationTextAdornment forIdentifier: #AssignmentNode withSize: 0} ].
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
						attributes: { GtYellowCircleExplanationTextAdornment forIdentifier: identifier withSize: 0} ].
			GtASTNodeStylerRule new
				nodeClassName: #RBLiteralValueNode;
				styleBlock: [ :aNode :aText |
					| identifier |
					(aNode value isInteger) ifTrue: [ identifier := #IntegerNode ].
					(aNode value isFloat) ifTrue: [ identifier := #FloatNode ].
					(aNode value isCharacter) ifTrue: [ identifier := #CharacterNode ].
					(aNode value isSymbol) ifTrue: [ identifier := #SymbolNode ].
					(aNode value isString and: [aNode value isSymbol not]) ifTrue: [ identifier := #StringNode ].
					(aText
						from: aNode start - 1
						to: aNode start - 1)
						attributes: {GtYellowCircleExplanationTextAdornment forIdentifier: identifier withSize: 0} ].
			GtASTNodeStylerRule new
				nodeClassName: #RBLiteralArrayNode;
				styleBlock: [ :aNode :aText |
					(aText
						from: aNode start - 1
						to: aNode start - 1)
						attributes: {GtYellowCircleExplanationTextAdornment forIdentifier: #LiteralArrayNode withSize: 0} ].
		}.
	
	^ compositeExplanationLinkStylerRules.
]

{ #category : #'*GToolkit-Inspector' }
GtSyntaxExplanationViewUtility >> gtExplanationLabelFor: aNodeNameSymbol [
	| lines nodeName label |
	nodeName := aNodeNameSymbol asRopedText from: 1 to: (aNodeNameSymbol size - 4).
	lines := OrderedCollection new.
	label := BrLabel new
		look: BrGlamorousLabelLook new;
		geometry: (BlRectangle cornerRadius: 4);
		padding: (BlInsets all: 5);
		hExact: 80.
	label explainer
		isExplanation: true;
		model: aNodeNameSymbol.
	label look: (BrInteractiveCommonLook new 
		default: [ :aWidget |
			lines do: [ :each | each removeFromParent ].
			lines removeAll.
			aWidget
				border: (BlBorder paint: Color transparent width: 2);
				background: Color transparent];
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
							aCommonParent addChild: (lines last) ]
						ifNone: [  ] ]  ] ).
	label addChildren: { BrLabel new text: nodeName; look: BrGlamorousLabelLook }.
	^ label.
]

{ #category : #'*GToolkit-Inspector' }
GtSyntaxExplanationViewUtility >> gtRegularLabelFor: aNodeNameSymbol [
	| nodeName |
	
	nodeName := aNodeNameSymbol asRopedText from: 1 to: (aNodeNameSymbol size - 4).
	
	^ BrLabel new
		text: (nodeName asRopedText glamorousRegularFont; foreground: Color gray);
		look: BrGlamorousLabelLook;
		padding: (BlInsets all: 5);
		hExact: 80.
		
]
