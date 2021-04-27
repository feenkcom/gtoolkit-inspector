Class {
	#name : #GtPharoSyntaxExplainer,
	#superclass : #BrStencil,
	#instVars : [
		'method',
		'tooltips',
		'tooltipsContainer',
		'tooltipsTarget',
		'coder'
	],
	#classInstVars : [
		'method'
	],
	#category : #'GToolkit-Inspector-Convenience and Utilities'
}

{ #category : #'as yet unclassified' }
GtPharoSyntaxExplainer >> astNodesList [
	| verticalContainer nodesCollection messageNodesGroup variableNodesGroup arrayNodesGroup literalValueNodesGroup otherNodesGroup |
	
	nodesCollection := method ast doSemanticAnalysis allChildren.
	 
	verticalContainer := BrVerticalPane new
		fitContent;
		padding: (BlInsets all: 10).
	
	otherNodesGroup := self verticalGroupElement hExact: 80.
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
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBSelfNode ])
		ifTrue: [ variableNodesGroup addChild: (self explanationLabelFor: #SelfNode) ]
		ifFalse: [ variableNodesGroup addChild: (self regularLabelFor: #SelfNode) ].
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBSuperNode ])
		ifTrue: [ variableNodesGroup addChild: (self explanationLabelFor: #SuperNode) ]
		ifFalse: [ variableNodesGroup addChild: (self regularLabelFor: #SuperNode) ].
	(nodesCollection anySatisfy: [ :aNode | aNode isKindOf: RBThisContextNode ])
		ifTrue: [ variableNodesGroup addChild: (self explanationLabelFor: #ThisContextNode) ]
		ifFalse: [ variableNodesGroup addChild: (self regularLabelFor: #ThisContextNode) ].
	
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
		aptitude: BrShadowAptitude";
		margin: (BlInsets all: 10)"
]

{ #category : #accessing }
GtPharoSyntaxExplainer >> create [
	| mainContainer nodesListContainer "coder" coderElement leftContainer rightContainer rightContainerLabel leftContainerLabel |
	
	mainContainer := BrHorizontalPane new
		matchParent;
		padding: (BlInsets all: 5).
	mainContainer explainer isExplanationHolder: true.
			
	leftContainer := BrVerticalPane new
		hFitContent;
		vMatchParent;
		padding: (BlInsets all: 5);
		margin: (BlInsets right: 20).
			
	rightContainer := BrVerticalPane new
		matchParent;
		padding: (BlInsets all: 5).

	tooltipsContainer := BrEditor new
		text: '' asRopedText;
		padding: (BlInsets all: 10);
		margin: (BlInsets top: 10 right: 0 bottom: 0 left: 0);
		constraintsDo: [ :c |
			c horizontal matchParent ];
		visibility: BlVisibility gone;
		border: (BlBorder paint: BrGlamorousColors textHighlightColor width: 2);
		aptitude: BrShadowAptitude + BrGlamorousEditorAptitude;
		vFitContent;
		background: BrGlamorousColors textHighlightColor.
	
	tooltipsTarget := BrButton new
		constraintsDo: [ :c | c ignoreByLayout ];
		size: 0 @ 0;
		elevation: (BlRelativeElevation elevation: 10);
		geometry: BlCircle new.

	nodesListContainer := self astNodesList.

	leftContainerLabel := (BrLabel new
		text: ('Syntactical constructs:' asRopedText 
			glamorousRegularFont; 
			foreground: Color gray);
		aptitude: BrGlamorousLabelAptitude;
		hFitContent;
		margin: (BlInsets top: 0 right: 0 bottom: 5 left: 0)).
	rightContainerLabel := (BrLabel new
		text: ('Method source code:' asRopedText
			glamorousRegularFont; 
			foreground: Color gray);
		aptitude: BrGlamorousLabelAptitude;
		margin: (BlInsets top: 0 right: 0 bottom: 5 left: 5)).

	coder := GtPharoMethodCoder new forMethod: method.
	coder explanationLink: GtPharoSyntaxExplanationStyler new.
	coderElement := (coder asCoderUIModel expanded: true) asElement margin: (BlInsets all: 0).
	coderElement vMatchParent.

	leftContainer addChild: leftContainerLabel.
	leftContainer addChild: nodesListContainer.

	rightContainer addChild: rightContainerLabel.
	rightContainer addChild: coderElement.
	rightContainer addChild: tooltipsContainer.

	mainContainer addChild: leftContainer.
	mainContainer addChild: rightContainer.

	^ mainContainer
]

{ #category : #accessing }
GtPharoSyntaxExplainer >> dividerBarElement [
	^ BlElement new
		constraintsDo: [ :c |
			c vertical matchParent ];
		width: 1;
		background: BrGlamorousColors lightBorderColor
]

{ #category : #'as yet unclassified' }
GtPharoSyntaxExplainer >> explanationLabelFor: aNodeNameSymbol [
	| nodeName |
	
	"Node names are in form ArrayNode, so we want to remove the Node suffix"
	nodeName := aNodeNameSymbol copyFrom: 1 to: (aNodeNameSymbol size - 4).
	
	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude new + (GtExplainerExplanationAptitude new explanationModel: aNodeNameSymbol) + (BrStyleCommonAptitude new
			hovered: [ :aStyle |
				aStyle background: (BrGlamorousColors textHighlightColor).
				aStyle
					do: [
						tooltipsContainer
							text: (tooltips at: aNodeNameSymbol);
							visibility: BlVisibility visible ]
					after: [
						tooltipsContainer
							text: '' asRopedText;
							visibility: BlVisibility gone ] ] );
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		text: nodeName;
		padding: (BlInsets all: 5)
]

{ #category : #accessing }
GtPharoSyntaxExplainer >> explanationLinkStylerRules [
	| compositeExplanationLinkStylerRules |
	compositeExplanationLinkStylerRules := GtCompositeExplanationLinkStyler forLinks:
		{
			GtASTNodeStylerRule new
				nodeClass: GtPharoProgramNode;
				styleBlock: [ :aNode :aText |
					aNode comments do: [:aCommentNode | 
					(aText
						from: aCommentNode start - 1
						to: aCommentNode start - 1)
						attributes: { GtTargetCircleWithUnderlineAdornment new identifier: #CommentNode; coder: coder; node: aNode; start: aCommentNode start; stop: aCommentNode stop} ] ].
			GtASTNodeStylerRule new
				nodeClass: GtPharoPragmaNode;
				styleBlock: [ :aNode :aText |
					(aText
						from: aNode start - 1
						to: aNode start - 1)
						attributes: { GtTargetCircleWithUnderlineAdornment new identifier: #PragmaNode; coder: coder; node: aNode; start: aNode left; stop: aNode right} ].
			GtASTNodeStylerRule new
				nodeClass: GtPharoReturnNode;
				styleBlock: [ :aNode :aText |
					(aText
						from: aNode start - 1
						to: aNode start - 1)
						attributes: { GtTargetCircleWithUnderlineAdornment new identifier: #ReturnNode; coder: coder; node: aNode; start: aNode start; stop: aNode start} ].
			GtASTNodeStylerRule new
				nodeClass: GtPharoCascadeNode;
				styleBlock: [ :aNode :aText |
					aNode semicolons do: [ :each |
						(aText
							from: each - 1
							to: each - 1)
							attributes: {GtTargetCircleWithUnderlineAdornment new identifier: #CascadeNode; coder: coder; node: aNode; start: each; stop: each}] ].
			GtASTNodeStylerRule new
				nodeClass: GtPharoArrayNode;
				styleBlock: [ :aNode :aText |
					(aText
						from: aNode left - 1
						to: aNode left - 1)
						attributes: { GtTargetCircleWithUnderlineAdornment new identifier: #ArrayNode; coder: coder; node: aNode; start: aNode left; stop: aNode right} ].
			GtASTNodeStylerRule new
				nodeClass: GtPharoMessageNode;
				styleBlock: [ :aNode :aText |
					| identifier |
					(aNode isBinary) ifTrue: [ identifier := #BinaryNode ].
					(aNode isUnary) ifTrue: [ identifier := #UnaryNode ].
					(aNode isKeyword) ifTrue: [ identifier := #KeywordNode ].
					(aText
							from: aNode keywordsIntervals first first - 1
							to: aNode keywordsIntervals first first - 1)
							attributes: { GtTargetCircleWithUnderlineAdornment new identifier: identifier; size: 0; coder: coder; node: aNode; start: (aNode start); stop: (aNode stop)} ].
			GtASTNodeStylerRule new
				nodeClass: GtPharoBlockNode;
				styleBlock: [ :aNode :aText |
					(aText
						from: aNode left - 1
						to: aNode left - 1)
						attributes: { GtTargetCircleWithUnderlineAdornment new identifier: #BlockNode; size: 0; coder: coder; node: aNode; start: aNode left; stop: aNode right} ].
			GtASTNodeStylerRule new
				nodeClass: GtPharoAssignmentNode;
				styleBlock: [ :aNode :aText |
					(aText
						from: aNode assignment - 1
						to: aNode assignment - 1)
						attributes: { GtTargetCircleWithUnderlineAdornment new identifier: #AssignmentNode; size: 0; coder: coder; node: aNode; start: aNode assignment; stop: aNode assignment + 1} ].
			GtASTNodeStylerRule new
				nodeClass: GtPharoVariableNode;
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
						attributes: { GtTargetCircleWithUnderlineAdornment new identifier: identifier; size: 0; coder: coder; node: aNode; start: aNode start; stop: aNode start + aNode name byteSize - 1} ].
			GtASTNodeStylerRule new
				nodeClass: GtPharoLiteralNode;
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
						attributes: {GtTargetCircleWithUnderlineAdornment new identifier: identifier; size: 0; coder: coder; node: aNode; start: aNode start; stop: aNode stop} ].
			GtASTNodeStylerRule new
				nodeClass: GtPharoArrayLiteralNode;
				styleBlock: [ :aNode :aText |
					(aText
						from: aNode start - 1
						to: aNode start - 1)
						attributes: {GtTargetCircleWithUnderlineAdornment new identifier: #LiteralArrayNode; size: 0; coder: coder; node: aNode; start: aNode start; stop: aNode stop} ].
		}.
	
	^ compositeExplanationLinkStylerRules.
]

{ #category : #'instance creation' }
GtPharoSyntaxExplainer >> forMethod: aMethod [
	method := aMethod.
]

{ #category : #accessing }
GtPharoSyntaxExplainer >> groupLabelWithText: aText [
	^ BrLabel new
		beSmallSize;
		aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
		text: aText;
		padding: (BlInsets all: 5);
		hExact: 70.
]

{ #category : #accessing }
GtPharoSyntaxExplainer >> horizontalGroupElement [
	^ BlElement new
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent.
			c padding: (BlInsets all: 5)];
		layout: BlLinearLayout horizontal.
]

{ #category : #initialization }
GtPharoSyntaxExplainer >> initialize [
	| associationsCollection |
	super initialize.
	
	associationsCollection := OrderedCollection new.
	tooltips := Dictionary new.
	
	associationsCollection addAll: { 
		#PragmaNode -> 'A pragma is a special annotation for methods.'.
		#ReturnNode -> 'A return node returns an object from a method.'.
		#UnaryNode -> 'A unary message has the following form: anObject aMessage.'.
		#BinaryNode -> 'A binary message has the following form: anObject aMessage anotherObject.'.
		#KeywordNode -> 'A keyword message has parameteres with the following form: anObject aKey: anotherObject aKey2: anotherObject2.'.
		#TemporaryNode -> 'A temporary is a variable declared in this method and it is only visible here.'.
		#ArgumentNode -> 'An argument is a variable received as a pramatere in the current method and it is only visible there.'.
		#GlobalNode -> 'A global is a variable declared in another class that can be used anywhere else.'.
		#SelfNode -> 'self represents the current object.'.
		#SuperNode -> 'super represents the parent class for the current class.'.
		#ThisContextNode -> 'thisContext is a pseudo-variable that represents the top frame of the execution stack. It is essential for implementing development tools like the debugger, and it is also used to implement exception handling and continuations.'.
		#ArrayNode -> 'An array is a collection of objects.'. 
		#LiteralArrayNode -> 'A literal array is a collection of literals.'. 
		#IntegerNode -> 'An integer is a value without a fractional component.'.
		#FloatNode -> 'A float is a value that can have a fractional component.'.
		#StringNode -> 'A string is an array of characters.'.
		#CharacterNode -> 'A character is a representation of a unicode value.'.
		#SymbolNode -> 'A symbol is a uniquely created string.'.
		#BlockNode -> 'A block contains multiple instructions to be executed.'.
		#AssignmentNode -> 'An assignment node assgines values to objects.'.
		#CascadeNode -> 'A cascade chains multiple messages, all applied to the same object.'.
		#CommentNode -> 'A comment is a description for a piece of code. It has no functionalty.' }.
	
	associationsCollection do: [ :each |
		tooltips at: each key put: (each value asRopedText glamorousRegularFont fontSize: 15) ].
]

{ #category : #'as yet unclassified' }
GtPharoSyntaxExplainer >> regularLabelFor: aNodeNameSymbol [
	| nodeName |
	
	nodeName := aNodeNameSymbol asRopedText from: 1 to: (aNodeNameSymbol size - 4).
	
	^ BrLabel new
		text: (nodeName asRopedText glamorousRegularFont; foreground: Color gray);
		aptitude: BrGlamorousLabelAptitude;
		padding: (BlInsets all: 5);
		hExact: 80.
		
]

{ #category : #accessing }
GtPharoSyntaxExplainer >> verticalGroupElement [
	^ BrVerticalPane new fitContent
]
