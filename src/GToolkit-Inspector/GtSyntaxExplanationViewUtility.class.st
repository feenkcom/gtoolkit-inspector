Class {
	#name : #GtSyntaxExplanationViewUtility,
	#superclass : #BrStencil,
	#instVars : [
		'method',
		'tooltips',
		'tooltipsContainer',
		'tooltipsTarget'
	],
	#classInstVars : [
		'method'
	],
	#category : #'GToolkit-Inspector'
}

{ #category : #'*GToolkit-Inspector' }
GtSyntaxExplanationViewUtility >> astNodesList [
	| verticalContainer nodesCollection messageNodesGroup variableNodesGroup arrayNodesGroup literalValueNodesGroup otherNodesGroup |
	
	nodesCollection := method ast doSemanticAnalysis allChildren.
	 
	verticalContainer := BlElement new
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ];
		layout: BlLinearLayout vertical;
		padding: (BlInsets all: 10).
	
	otherNodesGroup := self verticalGroupElement.
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBPragmaNode ])
		ifTrue: [ otherNodesGroup addChild: (self explanationLabelFor: #PragmaNode) ]
		ifFalse: [ otherNodesGroup addChild: (self regularLabelFor: #PragmaNode) ].
	
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBReturnNode ])
		ifTrue: [ otherNodesGroup addChild: (self explanationLabelFor: #ReturnNode) ]
		ifFalse: [ otherNodesGroup addChild: (self regularLabelFor: #ReturnNode) ].
	
	messageNodesGroup := self verticalGroupElement.
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBMessageNode) and: [ aNode isUnary ] ])
		ifTrue: [ messageNodesGroup addChild: (self explanationLabelFor: #UnaryNode) ]
		ifFalse: [ messageNodesGroup addChild: (self regularLabelFor: #UnaryNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBMessageNode) and: [ aNode isBinary ] ])
		ifTrue: [ messageNodesGroup addChild: (self explanationLabelFor: #BinaryNode) ]
		ifFalse: [ messageNodesGroup addChild: (self regularLabelFor: #BinaryNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBMessageNode) and: [ aNode isKeyword ] ])
		ifTrue: [ messageNodesGroup addChild: (self explanationLabelFor: #KeywordNode) ]
		ifFalse: [ messageNodesGroup addChild: (self regularLabelFor: #KeywordNode) ].
	
	variableNodesGroup := self verticalGroupElement.
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBVariableNode) and: [ aNode isTemp and: [ aNode isArg not ] ] ])
		ifTrue: [ variableNodesGroup addChild: (self explanationLabelFor: #TemporaryNode) ]
		ifFalse: [ variableNodesGroup addChild: (self regularLabelFor: #TemporaryNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBVariableNode) and: [ aNode isArg ] ])
		ifTrue: [ variableNodesGroup addChild: (self explanationLabelFor: #ArgumentNode) ]
		ifFalse: [ variableNodesGroup addChild: (self regularLabelFor: #ArgumentNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBVariableNode) and: [ aNode isGlobal ] ])
		ifTrue: [ variableNodesGroup addChild: (self explanationLabelFor: #GlobalNode) ]
		ifFalse: [ variableNodesGroup addChild: (self regularLabelFor: #GlobalNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBVariableNode) and: [ aNode isSelf ] ])
		ifTrue: [ variableNodesGroup addChild: (self explanationLabelFor: #SelfNode) ]
		ifFalse: [ variableNodesGroup addChild: (self regularLabelFor: #SelfNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBVariableNode) and: [ aNode isSuper ] ])
		ifTrue: [ variableNodesGroup addChild: (self explanationLabelFor: #SuperNode) ]
		ifFalse: [ variableNodesGroup addChild: (self regularLabelFor: #SuperNode) ].
	
	arrayNodesGroup := self verticalGroupElement.
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBArrayNode ])
		ifTrue: [ arrayNodesGroup addChild: (self explanationLabelFor: #ArrayNode) ]
		ifFalse: [ arrayNodesGroup addChild: (self regularLabelFor: #ArrayNode) ].
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBLiteralArrayNode ])
		ifTrue: [ arrayNodesGroup addChild: (self explanationLabelFor: #LiteralArrayNode) ]
		ifFalse: [ arrayNodesGroup addChild: (self regularLabelFor: #LiteralArrayNode) ].
	
	literalValueNodesGroup := self verticalGroupElement.
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBLiteralValueNode) and: [aNode value isInteger]])
		ifTrue: [ literalValueNodesGroup addChild: (self explanationLabelFor: #IntegerNode) ]
		ifFalse: [ literalValueNodesGroup addChild: (self regularLabelFor: #IntegerNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBLiteralValueNode) and: [ aNode value isFloat]])
		ifTrue: [ literalValueNodesGroup addChild: (self explanationLabelFor: #FloatNode) ]
		ifFalse: [ literalValueNodesGroup addChild: (self regularLabelFor: #FloatNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBLiteralValueNode) and: [ aNode value isCharacter]])
		ifTrue: [ literalValueNodesGroup addChild: (self explanationLabelFor: #CharacterNode) ]
		ifFalse: [ literalValueNodesGroup addChild: (self regularLabelFor: #CharacterNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBLiteralValueNode) and: [ aNode value isSymbol]])
		ifTrue: [ literalValueNodesGroup addChild: (self explanationLabelFor: #SymbolNode) ]
		ifFalse: [ literalValueNodesGroup addChild: (self regularLabelFor: #SymbolNode) ].
	(nodesCollection anySatisfy: [ :aNode | (aNode isKindOf: RBLiteralValueNode) and: [ aNode value isString and: [ aNode value isSymbol not]]])
		ifTrue: [ literalValueNodesGroup addChild: (self explanationLabelFor: #StringNode) ]
		ifFalse: [ literalValueNodesGroup addChild: (self regularLabelFor: #StringNode) ].
	
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBBlockNode ])
		ifTrue: [ otherNodesGroup addChild: (self explanationLabelFor: #BlockNode) ]
		ifFalse: [ otherNodesGroup addChild: (self regularLabelFor: #BlockNode) ].
	
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBAssignmentNode ])
		ifTrue: [ otherNodesGroup addChild: (self explanationLabelFor: #AssignmentNode) ]
		ifFalse: [ otherNodesGroup addChild: (self regularLabelFor: #AssignmentNode) ].
	
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBCascadeNode ])
		ifTrue: [ otherNodesGroup addChild: (self explanationLabelFor: #CascadeNode) ]
		ifFalse: [ otherNodesGroup addChild: (self regularLabelFor: #CascadeNode) ].
	
	(nodesCollection anySatisfy: [ :aNode | aNode comments notEmpty ])
		ifTrue: [ otherNodesGroup addChild: (self explanationLabelFor: #CommentNode) ]
		ifFalse: [ otherNodesGroup addChild: (self regularLabelFor: #CommentNode) ].
	
	
	verticalContainer addChildren: { 
		self horizontalGroupElement addChildren: {
			self groupLabelWithText: 'Messages'.
			self dividerBarElement.
			messageNodesGroup}.
		self horizontalGroupElement addChildren: {
			self groupLabelWithText: 'Variables'.
			self dividerBarElement.
			variableNodesGroup}.
		self horizontalGroupElement addChildren: {
			self groupLabelWithText: 'Arrays'.
			self dividerBarElement.
			arrayNodesGroup}.
		self horizontalGroupElement addChildren: {
			self groupLabelWithText: 'Literals'.
			self dividerBarElement.
			literalValueNodesGroup}.
		self horizontalGroupElement addChildren: {
			self groupLabelWithText: 'Others'.
			self dividerBarElement.
			otherNodesGroup}}.

	^ verticalContainer asScrollableElement 
		constraintsDo: [:c | c horizontal fitContent. c vertical matchParent.];
		background: Color white;
		look: BrShadowLook";
		margin: (BlInsets all: 10)"
]

{ #category : #'as yet unclassified' }
GtSyntaxExplanationViewUtility >> create [
	| mainContainer nodesListContainer coder coderElement leftContainer rightContainer rightContainerLabel leftContainerLabel |
	
	mainContainer := BlElement new
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent.
					c padding: (BlInsets all: 5)];
				layout: BlLinearLayout horizontal. 
	mainContainer explainer isExplanationHolder: true.
			
	leftContainer := BlElement new
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical matchParent. ];
		padding: (BlInsets all: 5);
		margin: (BlInsets right: 20);
		layout: BlLinearLayout vertical.
			
	rightContainer := BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent.
			c padding: (BlInsets all: 5)];
		layout: BlLinearLayout vertical.
	
	tooltipsContainer := BrEditor new
		text: '' asRopedText;
		padding: (BlInsets all: 10);
		margin: (BlInsets top: 10 right: 0 bottom: 0 left: 0);
		constraintsDo: [ :c |
			c horizontal matchParent ];
		visibility: BlVisibility gone;
		border: (BlBorder paint: BrGlamorousColors textHighlightColor width: 2);
		look: BrShadowLook + BrGlamorousEditorLook;
		vFitContent;
		background: (Color white).
	
	tooltipsTarget := BrButton new
		constraintsDo: [ :c | c ignoreByLayout ];
		size: 0 @ 0;
		elevation: (BlRelativeElevation elevation: 10);
		geometry: BlCircle new.
				
	nodesListContainer := self astNodesList.
			
	leftContainerLabel := (BrLabel new
		text: ('Syntactical constructs:' asRopedText 
			glamorousRegularFont; 
			foreground: Color gray;
			fontSize: 25);
		look: BrGlamorousLabelLook;
		hFitContent;
		margin: (BlInsets top: 0 right: 0 bottom: 5 left: 0)).
	rightContainerLabel := (BrLabel new
		text: ('Method source code:' asRopedText
			glamorousRegularFont; 
			foreground: Color gray;
			fontSize: 25);
		look: BrGlamorousLabelLook;
		margin: (BlInsets top: 0 right: 0 bottom: 5 left: 5)).
				
	coder := GtMethodCoder new forMethod: method.
	coder explanationLink: (self explanationLinkStylerRules).
	coderElement := (coder expanded: true) asElement margin: (BlInsets all: 0).
	coderElement forceLayout.
	coderElement vMatchParent.
			
	leftContainer addChild: leftContainerLabel.
	leftContainer addChild: nodesListContainer.
			
	rightContainer addChild: rightContainerLabel.
	rightContainer addChild: coderElement.
	rightContainer addChild: tooltipsContainer.
			
	mainContainer addChild: leftContainer.
	mainContainer addChild: rightContainer.
			
	^ mainContainer.
]

{ #category : #accessing }
GtSyntaxExplanationViewUtility >> dividerBarElement [
	^ BlElement new
		geometry: BlRectangle new;
		constraintsDo: [ :c |
			c vertical matchParent ];
		width: 1;
		background: BrGlamorousColors lightBorderColor
]

{ #category : #'*GToolkit-Inspector' }
GtSyntaxExplanationViewUtility >> explanationLabelFor: aNodeNameSymbol [
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
				background: Color transparent.
			tooltipsContainer
				text: '' asRopedText;
				visibility: BlVisibility gone];
		hovered: [ :aWidget |
			tooltipsContainer
				text: (tooltips at: aNodeNameSymbol);
				visibility: BlVisibility visible.
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
GtSyntaxExplanationViewUtility >> explanationLinkStylerRules [
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

{ #category : #'instance creation' }
GtSyntaxExplanationViewUtility >> forMethod: aMethod [
	method := aMethod.
]

{ #category : #accessing }
GtSyntaxExplanationViewUtility >> groupLabelWithText: aText [
	^ BrLabel new
		look: BrGlamorousLabelLook new;
		text: ((aText asRopedText) glamorousRegularFont; fontSize: 5; foreground: Color gray);
		padding: (BlInsets all: 5);
		hExact: 70.
]

{ #category : #accessing }
GtSyntaxExplanationViewUtility >> horizontalGroupElement [
	^ BlElement new
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent.
			c padding: (BlInsets all: 5)];
		layout: BlLinearLayout horizontal.
]

{ #category : #initialization }
GtSyntaxExplanationViewUtility >> initialize [
	| associationsCollection |
	super initialize.
	
	associationsCollection := OrderedCollection new.
	tooltips := Dictionary new.
	
	associationsCollection addAll: { 
		#PragmaNode -> 'I am a special annotation for methods.'.
		#ReturnNode -> 'I return a value from a method.'.
		#UnaryNode -> 'I am a message node with the following form: anObject aMessage.'.
		#BinaryNode -> 'I am a binary message with the following form: anObject aMessage anotherObject.'.
		#KeywordNode -> 'I am a keyword message. I can have parameteres and i have the following form: anObject aKey: anotherObject aKey2: anotherObject2.'.
		#TemporaryNode -> 'I am a variable declared in this method and only visible here.'.
		#ArgumentNode -> 'I am a variable received as a pramatere in this method and only visible in this method.'.
		#GlobalNode -> 'I am a global variable declared in another class but i can be used anywhere else.'.
		#SelfNode -> 'I represent the current object.'.
		#SuperNode -> 'I represent the parent class for the class we are in.'.
		#ArrayNode -> 'I am an array of objects.'. 
		#LiteralArrayNode -> 'i am an array of literals.'. 
		#IntegerNode -> 'I am an integer value.'.
		#FloatNode -> 'I am an float value.'.
		#StringNode -> 'I am an string value.'.
		#CharacterNode -> 'I am an character value.'.
		#SymbolNode -> 'I am an symbol value.'.
		#BlockNode -> 'I am a block containing multiple instructions to be executed.'.
		#AssignmentNode -> 'I assign values to objects.'.
		#CascadeNode -> 'I let multiple messages be applied to the same object.'.
		#CommentNode -> 'I am a comment for the code. I have no functionality.' }.
	
	associationsCollection do: [ :each |
		tooltips at: each key put: (each value asRopedText glamorousRegularFont; fontSize: 15) ].
]

{ #category : #'*GToolkit-Inspector' }
GtSyntaxExplanationViewUtility >> regularLabelFor: aNodeNameSymbol [
	| nodeName |
	
	nodeName := aNodeNameSymbol asRopedText from: 1 to: (aNodeNameSymbol size - 4).
	
	^ BrLabel new
		text: (nodeName asRopedText glamorousRegularFont; foreground: Color gray);
		look: BrGlamorousLabelLook;
		padding: (BlInsets all: 5);
		hExact: 80.
		
]

{ #category : #accessing }
GtSyntaxExplanationViewUtility >> verticalGroupElement [
	^ BlElement new
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent];
		layout: BlLinearLayout vertical.
]
