Class {
	#name : #GtActionCreator,
	#superclass : #GtCreator,
	#instVars : [
		'actionSource'
	],
	#category : #'GToolkit-Inspector-Convenience and Utilities'
}

{ #category : #'instance creation' }
GtActionCreator class >> actionCreatorForSource: aString in: aClass [
	^ self new
		actionSource: aString;
		behavior: aClass;
		createSource;
		yourself
]

{ #category : #initialization }
GtActionCreator >> actionBlockSource [
	| ast last buttonVariableName index vars |
	ast := RBParser parseExpression: actionSource.
	ast isSequence ifFalse: [ ast := RBSequenceNode statements: {ast} ].
	vars := Set withAll: ast allDefinedVariables.
	vars addAll: behavior allInstVarNames.
	buttonVariableName := 'button'.
	index := 0.
	[ vars includes: buttonVariableName ]
		whileTrue: [ index := index + 1.
			buttonVariableName := 'button' , index printString ].
	last := ast statements last.
	last isMessage
		ifTrue: [ (#(spawnObject: spawnTool:) includes: last selector)
				ifFalse: [ ast := RBSequenceNode
							temporaries: ast temporaries
							statements: ast statements allButLast
									, {RBMessageNode
												receiver: (RBMessageNode
														receiver: (RBVariableNode named: buttonVariableName)
														selector: #phlow)
												selector: #spawnObject:
												arguments: {last}} ] ].
	^ (RBBlockNode arguments: {RBVariableNode named: buttonVariableName} body: ast)
		formattedCode
]

{ #category : #'as yet unclassified' }
GtActionCreator >> actionSelector [
	| ast |
	ast := self actionSourceAST.
	(ast isSequence and: [ ast statements size = 1 ])
		ifTrue: [ ast := ast statements first ].
	^ (ast notNil and: [ ast isMessageSend and: [ ast selector isBinary not ] ])
		ifTrue: [ ast selector ]
]

{ #category : #accessing }
GtActionCreator >> actionSource [
	^ actionSource
]

{ #category : #accessing }
GtActionCreator >> actionSource: aString [
	actionSource := aString
]

{ #category : #private }
GtActionCreator >> actionSourceAST [
	^ [ GtPharoParser
		parse: actionSource
		startingAt: GtPharoParser startingStateForMethodSequence ]
		on: Error
		do: [ :ex | ex return ]
]

{ #category : #initialization }
GtActionCreator >> createSource [
	self
		source: (String
				streamContents: [ :stream | 
					stream << self newSelector
						<< ' anAction
	<gtAction>
	^ anAction button
		icon: BrGlamorousVectorIcons empty;
		tooltip: '''';
		action: ' << self actionBlockSource ])
]

{ #category : #private }
GtActionCreator >> defaultLabel [
	^ title
		ifNil: [ self actionSelector
				ifNil: [ 'Create <gtAction>' ]
				ifNotNil: [ :v | 'Create <gtAction> for ' , v ] ]
		ifNotNil: [ 'Create <gtAction> ' , title ]
]

{ #category : #accessing }
GtActionCreator >> protocol [
	^ #actions
]

{ #category : #'as yet unclassified' }
GtActionCreator >> selectorBase [
	| actionSelector name |
	actionSelector := self actionSelector.
	(actionSelector notNil and: [ actionSelector isBinary not ])
		ifTrue: [ name := actionSelector keywords first asString capitalized.
			^ name last = $: ifTrue: [ name allButLast ] ifFalse: [ name ] ].
	^ 'Action'
]
