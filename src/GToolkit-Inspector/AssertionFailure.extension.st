Extension { #name : #AssertionFailure }

{ #category : #'*GToolkit-Inspector' }
AssertionFailure >> gtScripter [
	| assertionContext scripterValue |
	
	BlDevScripterStepExecutionIndicator 
		ifScripter: [ :aScripter | ^ aScripter ] 
		ifNone: [ ].
	self gtHasStack ifFalse: [ ^ nil ].

	assertionContext := self signalerContext
			findContextSuchThat: [ :ctx | 
				(ctx hasTemporaryVariableNamed: #aScripter)
					or: [ ctx hasTemporaryVariableNamed: #scripter ] ].
	assertionContext ifNil: [ ^ nil ].

	scripterValue :=  (assertionContext hasTemporaryVariableNamed: #aScripter)
		ifTrue: [ assertionContext readVariableNamed: #aScripter ]
		ifFalse: [ assertionContext readVariableNamed: #scripter].

	^ (scripterValue isKindOf: BlScripter)
		ifTrue: [ scripterValue ]
		ifFalse: [ nil ]
]
