Extension { #name : #GtPharoMethodCoder }

{ #category : #'*GToolkit-Inspector' }
GtPharoMethodCoder >> gtViewStylerAddOnFor: anAST into: coderAddOns viewModel: aGtPharoSourceCoderViewModel [
	<gtAstCoderAddOns: 10>
	| styler |
	styler := aGtPharoSourceCoderViewModel selfObject
			ifNotNil: [ :obj | GtViewStyler new receiver: obj ]
			ifNil: [ GtViewStyler new receiverClass: self behavior ].
	coderAddOns addStyler: styler
]
