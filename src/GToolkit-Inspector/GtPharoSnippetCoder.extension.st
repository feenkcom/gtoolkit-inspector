Extension { #name : #GtPharoSnippetCoder }

{ #category : #'*GToolkit-Inspector' }
GtPharoSnippetCoder >> addCreateGtViewMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns: 90>
	<gtCoderContextMenuAddOns>
	behavior = nil class ifTrue: [ ^ self ].
	aCoderViewModel styledText
		attributesDo: [ :attrs | 
			attrs
				detect: [ :each | each class = GtPlaygroundEvaluatedCodeButtonAttribute ]
				ifFound: [ :each | 
					^ (GtViewCreator
						viewCreatorsForObject: each result
						andSource: (each evaluationInterval
								ifNil: [ aCoderViewModel styledText asString ]
								ifNotNil: [ :interval | aCoderViewModel styledText asString copyFrom: interval first to: interval last ])
						in: behavior)
						do: [ :creator | 
							creator selfObjectHolder: aCoderViewModel selfObjectHolder.
							(self
								addExplicitContextMenu: creator label
								block: [ :aCoderElement :aTextualCoderViewModel :aCoderAction | creator asMenuItem id: #'create-gtView' ]
								to: coderAddOns) ifNotNil: [ :anAction | anAction priority: 90 ] ] ]
				ifNone: [  ] ]
]
