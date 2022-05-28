Class {
	#name : #GtRecursionSummaryFilter,
	#superclass : #GtMessageTallyFilter,
	#category : #'GToolkit-Inspector-Message Tallies'
}

{ #category : #examples }
GtRecursionSummaryFilter class >> exampleSummarizeRecursion [
	<gtExample>
	
	| originalTally newTally slowFactorial |
	originalTally := self messageTallyForRecursion.
	slowFactorial := originalTally receivers detect: [ :each | each method selector = #slowFactorial ].
	self assert: slowFactorial tally equals: 11.
	self assert: slowFactorial receivers notEmpty.
	newTally := originalTally applyFilter: self new.
	slowFactorial := newTally receivers detect: [ :each | each method selector = #slowFactorial ].
	self assert: slowFactorial tally equals: 11.
	self assert: slowFactorial receivers isEmpty.
	self assert: newTally tally equals: originalTally tally.
	^ newTally
]

{ #category : #filtering }
GtRecursionSummaryFilter >> filter: aMessageTally [
	| newTally |
	newTally := aMessageTally filterCopy changeToOuterMethod.
	self filterOutRecursion: aMessageTally usingStack: (OrderedCollection with: newTally).
	^ newTally
]

{ #category : #filtering }
GtRecursionSummaryFilter >> filterOutRecursion: aMessageTally usingStack: anArray [
	aMessageTally receivers
		do:
			[ :each | 
			| compiledMethod index newStack newTally |
			compiledMethod := each method method.
			compiledMethod isFromTrait
				ifTrue:
					[ compiledMethod origin
						ifNotNil: [ :origin | (origin methodNamed: compiledMethod selector) ifNotNil: [ :m | compiledMethod := m ] ] ].
			index := (1 to: anArray size) detect: [ :i | (anArray at: i) method == compiledMethod ] ifNone: [ anArray size + 1 ].
			index > anArray size
				ifTrue:
					[ newTally := anArray last receivers detect: [ :tally | tally method == compiledMethod ] ifNone: [  ].
					newTally
						ifNotNil: [ newTally bumpBy: each tally ]
						ifNil:
							[ newTally := each filterCopy.
							newTally setMethod: compiledMethod.
							newTally changeToOuterMethod.
							anArray last addReceiver: newTally ].
					newStack := anArray copyWith: newTally ]
				ifFalse:
					[ newStack := anArray first: index.
					index + 1 to: anArray size do: [ :i | (anArray at: i) bumpBy: each tally negated ] ].
			self filterOutRecursion: each usingStack: newStack ]
]
