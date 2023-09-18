Class {
	#name : #GtGatherMessageTallyFilter,
	#superclass : #GtMessageTallyFilter,
	#instVars : [
		'rootMethod'
	],
	#category : #'GToolkit-Inspector-Message Tallies'
}

{ #category : #'instance creation' }
GtGatherMessageTallyFilter class >> forMethod: aCompiledMethod [
	^ (self new)
		rootMethod: aCompiledMethod;
		yourself
]

{ #category : #examples }
GtGatherMessageTallyFilter class >> gatherExample [
	<gtExample>
	
	| originalTally newTally method |
	method := String compiledMethodAt: #numArgs.
	originalTally := self messageTallyForGather.
	newTally := originalTally applyFilter: (self forMethod: method).
	self assert: newTally tally + 5 equals: originalTally tally.
	^ newTally
]

{ #category : #'api - stream' }
GtGatherMessageTallyFilter >> addChildrenOf: aMessageTally to: result [
	aMessageTally receivers
		do:
			[ :each | 
			| tally |
			tally := result receivers
				detect: [ :child | child method == each method ]
				ifNone:
					[ tally := aMessageTally class new class: each theClass method: each method.
					result addReceiver: tally.
					tally ].
			tally bumpBy: each tally.
			self addChildrenOf: each to: tally ]
]

{ #category : #'api - stream' }
GtGatherMessageTallyFilter >> filter: aMessageTally [
	| result |
	result := aMessageTally class new class: rootMethod methodClass method: rootMethod.
	self filterRootInto: result from: aMessageTally.
	^ result
]

{ #category : #'api - stream' }
GtGatherMessageTallyFilter >> filterRootInto: result from: aMessageTally [
	aMessageTally method == rootMethod
		ifTrue:
			[ result bumpBy: aMessageTally tally.
			self addChildrenOf: aMessageTally to: result ]
		ifFalse: [ aMessageTally receivers do: [ :each | self filterRootInto: result from: each ] ]
]

{ #category : #initialization }
GtGatherMessageTallyFilter >> rootMethod: aCompiledMethod [
	rootMethod := aCompiledMethod
]
