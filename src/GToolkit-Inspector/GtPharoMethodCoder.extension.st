Extension { #name : #GtPharoMethodCoder }

{ #category : #'*GToolkit-Inspector' }
GtPharoMethodCoder >> addInlineGtViewForwarderFor: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns: 220>
	| node |
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
	coderAddOns
		addContextMenuItem: (self
				createLabel: 'Inline <gtView>'
				description: node literalValue)
		hover: (self highlightNodeBlock: node)
		leave: self removeHighlightBlock
		action: [ :aSourceCoderViewModel :element | 
			(GtInlineForwardViewRefactoringController new
				implementor: nil;
				node: node;
				sourceCoderViewModel: aSourceCoderViewModel) executeIn: element ]
		id: #'context-menu--inline-gtView'
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
