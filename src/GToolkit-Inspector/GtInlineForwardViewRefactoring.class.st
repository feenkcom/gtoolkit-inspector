Class {
	#name : #GtInlineForwardViewRefactoring,
	#superclass : #RBMethodRefactoring,
	#instVars : [
		'selector',
		'interval',
		'extractedMethodSelector',
		'literalNode'
	],
	#category : #'GToolkit-Inspector-Refactoring'
}

{ #category : #'instance creation' }
GtInlineForwardViewRefactoring class >> model: aModel inline: anInterval inMethod: selector forClass: aClass [
	^ self new
		model: aModel;
		methodClass: aClass;
		selector: selector;
		interval: anInterval;
		yourself
]

{ #category : #transforming }
GtInlineForwardViewRefactoring >> addCascadesToReturn: aReturn [
	| cascade messages newMessages newReceiver updated |
	(aReturn value isMessage and: [ aReturn value selector = #empty ])
		ifTrue: [ ^ self ].
	cascade := self findCascadeMessage.
	messages := cascade messages
			reject: [ :each | #(object: view:) includes: each selector ].
	aReturn value isCascade
		ifTrue: [ updated := false.
			newMessages := aReturn value messages collect: #copy.
			2
				to: newMessages size
				do: [ :i | (newMessages at: i) receiver: newMessages first receiver ].
			messages
				do: [ :each | 
					(#(title: priority:) includes: each selector)
						ifTrue: [ newMessages
								do: [ :new | 
									new selector = each selector
										ifTrue: [ updated := true.
											new arguments first replaceWith: each arguments first copy ] ] ].
					updated
						ifFalse: [ newMessages
								add: (each copy
										receiver: newMessages first receiver;
										yourself) ] ].
			aReturn value replaceWith: (RBCascadeNode messages: newMessages) ]
		ifFalse: [ newReceiver := aReturn value copy.
			newMessages := messages collect: [ :each | each copy receiver: newReceiver ].
			aReturn value
				replaceWith: (newMessages size = 1
						ifTrue: [ newMessages first ]
						ifFalse: [ RBCascadeNode messages: newMessages ]) ]
]

{ #category : #transforming }
GtInlineForwardViewRefactoring >> basicTransform [
	self extractMethod.
	self convertToDirectCall.
	self inlineGtViewMethod.
	self updateCascadedMessages.
	self inlineExtractedMethod.
	self gtCleanupChanges
]

{ #category : #transforming }
GtInlineForwardViewRefactoring >> convertToDirectCall [
	| method ast newAst objectBody |
	method := class methodFor: extractedMethodSelector.
	ast := method ast.
	ast body statements first value messages
		do: [ :each | each selector = #object: ifTrue: [ objectBody := each arguments first body ] ].
	newAst := ast copy.
	newAst body: objectBody copy.
	newAst body statements last
		replaceWith: (RBReturnNode
				value: (RBMessageNode
						receiver: objectBody statements last copy
						selector: self literalNode value
						arguments: {self findCascadeMessage receiver receiver copy})).
	method compileTree: newAst
]

{ #category : #transforming }
GtInlineForwardViewRefactoring >> extractMethod [
	| refactoring |
	refactoring := RBExtractMethodRefactoring
				model: self model
				extract: self findCascadeMessage sourceInterval
				from: selector
				in: class.
	refactoring setOption: #methodName
		toUse:
			[:methodName :ref |
			extractedMethodSelector := self
						uniqueMethodNameFor: methodName arguments size.
			methodName
				selector: extractedMethodSelector;
				yourself].
	self performCompositeRefactoring: refactoring
]

{ #category : #transforming }
GtInlineForwardViewRefactoring >> findCascadeMessage [
	^ self literalNode parent parent
]

{ #category : #private }
GtInlineForwardViewRefactoring >> findNode [
	| ast |
	ast := self methodClass parseTreeForSelector: selector.
	ast nodesDo: [ :each | (self isForwardingLiteral: each) ifTrue: [ ^ each ] ].
	^ nil
]

{ #category : #transforming }
GtInlineForwardViewRefactoring >> inlineExtractedMethod [
	| refactoring |
	refactoring := RBInlineAllSendersRefactoring
			model: self model
			sendersOf: extractedMethodSelector
			in: class.
	self performCompositeRefactoring: refactoring
]

{ #category : #transforming }
GtInlineForwardViewRefactoring >> inlineGtViewMethod [
	| method ast refactoring |
	method := class methodFor: extractedMethodSelector.
	ast := method ast.
	refactoring := RBInlineMethodFromComponentRefactoring
			model: self model
			inline: ast body statements last value sourceInterval
			inMethod: extractedMethodSelector
			forClass: class.
	self performCompositeRefactoring: refactoring
]

{ #category : #accessing }
GtInlineForwardViewRefactoring >> interval [
	^ interval
]

{ #category : #accessing }
GtInlineForwardViewRefactoring >> interval: anObject [
	interval := anObject
]

{ #category : #testing }
GtInlineForwardViewRefactoring >> isForwardingLiteral: aNode [
	| viewMessage cascade |
	aNode isLiteralNode ifFalse: [ ^ false ].
	aNode sourceInterval = interval ifFalse: [ ^ false ].
	aNode value isSymbol ifFalse: [ ^ false ].
	aNode value numArgs = 1 ifFalse: [ ^ false ].
	viewMessage := aNode parent.
	viewMessage isMessage ifFalse: [ ^ false ].
	viewMessage arguments first == aNode ifFalse: [ ^ false ].
	viewMessage selector = #view: ifFalse: [ ^ false ].
	viewMessage receiver isMessage ifFalse: [ ^ false ].
	viewMessage receiver selector = #forward ifFalse: [ ^ false ].
	viewMessage receiver receiver isVariable ifFalse: [ ^ false ].
	viewMessage receiver receiver = aNode methodNode arguments first
		ifFalse: [ ^ false ].
	cascade := viewMessage parent.
	cascade isCascade ifFalse: [ ^ false ].
	^ cascade messages
		anySatisfy: [ :each | each selector = #object: and: [ each arguments first isBlock ] ]
]

{ #category : #accessing }
GtInlineForwardViewRefactoring >> literalNode [
	^ literalNode ifNil: [ literalNode := self findNode ]
]

{ #category : #accessing }
GtInlineForwardViewRefactoring >> methodClass: aClass [
	class := model classFor: aClass
]

{ #category : #preconditions }
GtInlineForwardViewRefactoring >> preconditions [
	^ (RBCondition definesSelector: selector in: self methodClass)
		& (RBCondition
				withBlock: [ | node |
					node := self literalNode.
					node ifNil: [ self refactoringError: 'Cannot find node to inline' ].
					true ])
]

{ #category : #transforming }
GtInlineForwardViewRefactoring >> privateTranform [
	self basicTransform
]

{ #category : #accessing }
GtInlineForwardViewRefactoring >> selector [
	^ selector
]

{ #category : #accessing }
GtInlineForwardViewRefactoring >> selector: anObject [
	selector := anObject
]

{ #category : #transforming }
GtInlineForwardViewRefactoring >> transform [
	self basicTransform
]

{ #category : #transforming }
GtInlineForwardViewRefactoring >> updateCascadedMessages [
	| method ast |
	method := class methodFor: extractedMethodSelector.
	ast := method ast.
	ast
		nodesDo: [ :each | each isReturn ifTrue: [ self addCascadesToReturn: each ] ].
	method compileTree: ast
]
