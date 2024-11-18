Extension { #name : #GtPharoSnippetCoder }

{ #category : #'*GToolkit-Inspector' }
GtPharoSnippetCoder >> addCreateGtViewMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns: 90>
	behavior = nil class ifTrue: [ ^ self ].
	aCoderViewModel styledText
		attributesDo: [ :attrs | 
			attrs
				detect: [ :each | each class = GtPlaygroundEvaluatedCodeButtonAttribute ]
				ifFound: [ :each | 
					^ (GtViewCreator
						viewCreatorsForObject: each result
						andSource: aCoderViewModel styledText asString
						in: behavior)
						do: [ :creator | 
							self
								addContextMenuItemWithNoShortcutFrom: (GtViewCreatorShortcut new
										name: creator label;
										viewCreator: creator;
										yourself)
								withId: #'create-gtView'
								to: coderAddOns ] ]
				ifNone: [  ] ]
]
