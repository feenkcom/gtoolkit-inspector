Extension { #name : #AssertionFailure }

{ #category : #'*GToolkit-Inspector' }
AssertionFailure >> gtScripter [
	| assertionContext scripterValue |
	self gtHasStack ifFalse: [ ^ nil ].

	assertionContext := self signalerContext
			findContextSuchThat: [ :ctx | 
				(ctx hasTemporaryVariableNamed: #aScripter)
					or: [ ctx hasTemporaryVariableNamed: #scripter ] ].
	assertionContext ifNil: [ ^ nil ].

	scripterValue := assertionContext readVariableNamed: #aScripter.
	scripterValue
		ifNil: [ scripterValue := assertionContext readVariableNamed: #scripter ].

	^ (scripterValue isKindOf: BlScripter)
		ifTrue: [ scripterValue ]
		ifFalse: [ nil ]
]
