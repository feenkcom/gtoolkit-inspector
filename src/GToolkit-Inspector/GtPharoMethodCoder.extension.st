Extension { #name : #GtPharoMethodCoder }

{ #category : #'*GToolkit-Inspector' }
GtPharoMethodCoder >> addInlineGtViewForwarderFor: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns: 220>
	| node implementer objectCode lastValue |
	anAst isMethod ifFalse: [ ^ self ].
	(anAst pragmasNamed: #gtView) ifNil: [ ^ self ].
	node := self nodeFrom: aCoderViewModel.
	node ifNil: [ ^ self ].
	node isLiteral ifFalse: [ ^ self ].
	node isSymbol ifFalse: [ ^ self ].
	node literalValue numArgs = 1 ifFalse: [ ^ self ].
	node parent isMessage ifFalse: [ ^ self ].
	node parent selector = #view: ifFalse: [ ^ self ].
	node parent parent isCascade ifFalse: [ ^ self ].
	node parent parent receiver isMessageSend ifFalse: [ ^ self ].
	node parent parent receiver selector = #forward ifFalse: [ ^ self ].
	node parent parent messages
		detect: [ :each | each selector = #object: ]
		ifFound: [ :each | each arguments first isBlock ifTrue: [ objectCode := each arguments first body ] ].
	objectCode ifNil: [ ^ self ].
	aCoderViewModel styledText
		attributesDo: [ :attrs | 
			attrs
				detect: [ :each | each class = GtPlaygroundEvaluatedCodeButtonAttribute ]
				ifFound: [ :each | 
					each evaluationInterval
						ifNotNil: [ :interval | 
							(interval first <= objectCode startPosition
								and: [ interval last >= objectCode stopPosition
										and: [ interval first > objectCode parent startPosition
												and: [ interval last < objectCode parent stopPosition ] ] ])
								ifTrue: [ implementer := each result class ] ] ] ].
	implementer
		ifNil: [ lastValue := objectCode statements last.
			lastValue isLiteral ifTrue: [ implementer := lastValue literalValue class ].
			lastValue isVariable
				ifTrue: [ lastValue isSelf ifTrue: [ implementer := self behavior ].
					aCoderViewModel selfObject
						ifNotNil: [ :obj | 
							obj class
								slotNamed: lastValue variableName
								ifFound: [ :slot | implementer := (slot read: obj) class ]
								ifNone: [  ] ] ] ].
	implementer
		ifNotNil: [ implementer := implementer whichClassIncludesSelector: node literalValue ].
	(coderAddOns
		addContextMenuItem: (self
				createLabel: 'Inline <gtView>'
				description: node literalValue)
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodeBlock: node)
		leave: self removeHighlightBlock
		action: [ :aSourceCoderViewModel :element | 
			(GtInlineForwardViewRefactoringController new
				implementor: implementer;
				node: node;
				sourceCoderViewModel: aSourceCoderViewModel) executeIn: element ]
		id: #'context-menu--inline-gtView')
			ifNotNil: [ :anAction | anAction priority: 220 ]
]

{ #category : #'*GToolkit-Inspector' }
GtPharoMethodCoder >> gtViewStylerAddOnFor: anAST into: coderAddOns viewModel: aGtPharoSourceCoderViewModel [
	<gtAstCoderAddOns: 10>
	| styler |
	styler := aGtPharoSourceCoderViewModel selfObject
			ifNotNil: [ :obj | GtViewStyler new receiver: obj ]
			ifNil: [ GtViewStyler new receiverClass: self behavior ].
	coderAddOns addStyler: styler
]
