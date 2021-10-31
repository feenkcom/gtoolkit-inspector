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
GtPharoSyntaxExplainer >> constructsList [
	| verticalContainer messageNodesGroup variableNodesGroup arrayNodesGroup literalValueNodesGroup otherNodesGroup sourceCode ast detectedConstructs |
	sourceCode := method sourceCode.
	ast := GtPharoParser parseWithErrors: sourceCode startingAt: GtPharoParser startingStateForMethod.
	detectedConstructs := GtPharoSyntaxExplanationStyler new style: sourceCode asRopedText ast: ast; detectedConstructs.
	verticalContainer := BrVerticalPane new
		fitContent;
		padding: (BlInsets all: 10).
	otherNodesGroup := self verticalGroupElement hExact: 80.
	#(PragmaNode ReturnNode BlockNode AssignmentNode CascadeNode CommentNode) do: [ :each |
			(detectedConstructs includes: each) 
				ifTrue: [ otherNodesGroup addChild: (self explanationLabelFor: each) ]
				ifFalse: [ otherNodesGroup addChild: (self regularLabelFor: each) ] ].
	messageNodesGroup := self verticalGroupElement.
	#(UnaryNode BinaryNode KeywordNode ) do: [ :each |
			(detectedConstructs includes: each) 
				ifTrue: [ messageNodesGroup addChild: (self explanationLabelFor: each) ]
				ifFalse: [ messageNodesGroup addChild: (self regularLabelFor: each) ] ].
	variableNodesGroup := self verticalGroupElement.
	#(TemporaryNode ArgumentNode GlobalNode SelfNode SuperNode ThisContextNode) do: [ :each |
			(detectedConstructs includes: each) 
				ifTrue: [ variableNodesGroup addChild: (self explanationLabelFor: each) ]
				ifFalse: [ variableNodesGroup addChild: (self regularLabelFor: each) ] ].
	arrayNodesGroup := self verticalGroupElement.
	#(ArrayNode LiteralArrayNode) do: [ :each |
			(detectedConstructs includes: each) 
				ifTrue: [ arrayNodesGroup addChild: (self explanationLabelFor: each) ]
				ifFalse: [ arrayNodesGroup addChild: (self regularLabelFor: each) ] ].
	literalValueNodesGroup := self verticalGroupElement.
	#(IntegerNode FloatNode CharacterNode SymbolNode StringNode) do: [ :each |
			(detectedConstructs includes: each) 
				ifTrue: [ literalValueNodesGroup addChild: (self explanationLabelFor: each) ]
				ifFalse: [ literalValueNodesGroup addChild: (self regularLabelFor: each) ] ].	
	
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
		aptitude: BrShadowAptitude new
]

{ #category : #accessing }
GtPharoSyntaxExplainer >> create [
	| mainContainer constructsContainer coderElement leftContainer rightContainer rightContainerLabel leftContainerLabel |
	
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
		geometry: BlCircleGeometry new.

	constructsContainer := self constructsList.

	leftContainerLabel := (BrLabel new
		text: ('Pharo constructs:' asRopedText 
			glamorousRegularFont; 
			foreground: Color gray);
		aptitude: BrGlamorousLabelAptitude;
		hFitContent;
		margin: (BlInsets top: 0 right: 0 bottom: 5 left: 0)).
	rightContainerLabel := (BrLabel new
		text: ('Method:' asRopedText
			glamorousRegularFont; 
			foreground: Color gray);
		aptitude: BrGlamorousLabelAptitude;
		margin: (BlInsets top: 0 right: 0 bottom: 5 left: 5)).

	coder := GtPharoMethodCoder new forMethod: method.
	coder explanationLink: GtPharoSyntaxExplanationStyler new.
	coderElement := (coder asCoderUIModel expanded: true) asElement margin: (BlInsets all: 0).
	coderElement vMatchParent.

	leftContainer addChild: leftContainerLabel.
	leftContainer addChild: constructsContainer.

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
