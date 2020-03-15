Extension { #name : #GtSyntaxExplanationViewUtility }

{ #category : #'*GToolkit-Inspector' }
GtSyntaxExplanationViewUtility class >> gtAstNodesList [
	| verticalContainer nodesCollection pragmaNodeGroup returnNodeGroup messageNodesGroup variableNodesGroup arrayNodesGroup literalValueNodesGroup assignmentNodeGroup blockNodeGroup cascadeNodeGroup |
	
	nodesCollection := method ast doSemanticAnalysis allChildren.
	 
	verticalContainer := BlElement new
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical matchParent.
			c padding: (BlInsets all: 10)];
		layout: BlLinearLayout vertical;
		background: Color white;
		look: BrShadowLook.
	
	pragmaNodeGroup := self gtVerticalGroupElement.
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBPragmaNode ])
		ifTrue: [ pragmaNodeGroup addChild: (self gtExplanationLabelFor: #PragmaNode) ]
		ifFalse: [ pragmaNodeGroup addChild: (self gtRegularLabelFor: #PragmaNode) ].
	
	returnNodeGroup := self gtVerticalGroupElement.	
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBReturnNode ])
		ifTrue: [ returnNodeGroup addChild: (self gtExplanationLabelFor: #ReturnNode) ]
		ifFalse: [ returnNodeGroup addChild: (self gtRegularLabelFor: #ReturnNode) ].
	
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
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBLiteralValueNode ])
		ifTrue: [ literalValueNodesGroup addChild: (self gtExplanationLabelFor: #LiteralValueNode) ]
		ifFalse: [ literalValueNodesGroup addChild: (self gtRegularLabelFor: #LiteralValueNode) ].
	
	blockNodeGroup := self gtVerticalGroupElement.
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBBlockNode ])
		ifTrue: [ blockNodeGroup addChild: (self gtExplanationLabelFor: #BlockNode) ]
		ifFalse: [ blockNodeGroup addChild: (self gtRegularLabelFor: #BlockNode) ].
	
	assignmentNodeGroup := self gtVerticalGroupElement.
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBAssignmentNode ])
		ifTrue: [ assignmentNodeGroup addChild: (self gtExplanationLabelFor: #AssignmentNode) ]
		ifFalse: [ assignmentNodeGroup addChild: (self gtRegularLabelFor: #AssignmentNode) ].
	
	cascadeNodeGroup := self gtVerticalGroupElement.
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBCascadeNode ])
		ifTrue: [ cascadeNodeGroup addChild: (self gtExplanationLabelFor: #CascadeNode) ]
		ifFalse: [ cascadeNodeGroup addChild: (self gtRegularLabelFor: #CascadeNode) ].
	
	verticalContainer addChildren: { 
		self gtHorizontalGroupElement addChildren: {
			self gtGroupLabelWithText: 'Pragma Nodes'.
			self gtDividerBarElement.
			pragmaNodeGroup}.
		self gtHorizontalGroupElement addChildren: {
			self gtGroupLabelWithText: 'Return Nodes'.
			self gtDividerBarElement.
			returnNodeGroup}.
		self gtHorizontalGroupElement addChildren: {
			self gtGroupLabelWithText: 'Message Nodes'.
			self gtDividerBarElement.
			messageNodesGroup}.
		self gtHorizontalGroupElement addChildren: {
			self gtGroupLabelWithText: 'Variable Nodes'.
			self gtDividerBarElement.
			variableNodesGroup}.
		self gtHorizontalGroupElement addChildren: {
			self gtGroupLabelWithText: 'Array Nodes'.
			self gtDividerBarElement.
			arrayNodesGroup}.
		self gtHorizontalGroupElement addChildren: {
			self gtGroupLabelWithText: 'LiteralValue Nodes'.
			self gtDividerBarElement.
			literalValueNodesGroup}.
		self gtHorizontalGroupElement addChildren: {
			self gtGroupLabelWithText: 'Block Nodes'.
			self gtDividerBarElement.
			blockNodeGroup}.
		self gtHorizontalGroupElement addChildren: {
			self gtGroupLabelWithText: 'Assignment Nodes'.
			self gtDividerBarElement.
			assignmentNodeGroup}.
		self gtHorizontalGroupElement addChildren: {
			self gtGroupLabelWithText: 'Cascade Nodes'.
			self gtDividerBarElement.
			cascadeNodeGroup}}.

	^ verticalContainer
"		width: 270."
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
GtSyntaxExplanationViewUtility class >> gtExplanationLabelFor: aNodeNameSymbol [
	| lines nodeName label button container |
	
	nodeName := aNodeNameSymbol asRopedText from: 1 to: (aNodeNameSymbol size - 4).
	lines := OrderedCollection new.
	
	container := BlElement new
		layout: BlLinearLayout horizontal;
		padding: (BlInsets top: 0 right: 0 bottom: 5 left: 0);
		constraintsDo: [ :c |
			c vertical fitContent.
			c horizontal matchParent ].
		
	label := BrLabel new
		look: BrGlamorousLabelLook new;
		text: nodeName asRopedText glamorousRegularFont;
		padding: (BlInsets top: 0 right: 0 bottom: 0 left: 5);
		constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal matchParent ].
	
	button := BrButton new
		clipChildren: false;
		layout: BlLinearLayout vertical;
		geometry: (BlRectangle cornerRadius: 4);
		padding: (BlInsets all: 5);
		margin: (BlInsets top: 5 right: 0 bottom: 5 left: 5);
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ].
	button explainer
		isExplanation: true;
		model: aNodeNameSymbol.
		
	container addChild: button.
	container addChild: label.
	
	button look: (BrInteractiveCommonLook new 
		default: [ :aWidget |
			lines do: [ :each | each removeFromParent ].
			lines removeAll.
			aWidget
				border: (BlBorder paint: BrGlamorousColors textHighlightColor width: 2);
				background: Color transparent.
			aWidget parent
				border: (BlBorder paint: Color transparent);
				background: Color transparent ];
		hovered: [ :aWidget |
			aWidget parent border: (BlBorder paint: BrGlamorousColors textHighlightColor width: 2).
			aWidget parent background: (BrGlamorousColors textHighlightColor alpha: 0.5).
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
	
	^ container.
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
