Class {
	#name : #GtInspectorVariableValuePairsExamples,
	#superclass : #Object,
	#category : #'GToolkit-Inspector-Examples'
}

{ #category : #object }
GtInspectorVariableValuePairsExamples >> testArrayPairsEqualLimit [
	<gtExample>
	| limit pairs |	
		
	limit := 2 * GtInspector indexableDisplayLimit.
	pairs := (1 to: limit) asArray gtInspectorVariableValuePairs.
	
	self assert: pairs size equals: limit.
	self assert: ((pairs collect: [ :each | each key ]) 
		allSatisfy: [ :e | (pairs at: e) = (e->e) ]).
	self assert: (pairs collect: [ :each | each key ]) equals: (1 to: limit) asOrderedCollection.
	
	^ pairs
]

{ #category : #object }
GtInspectorVariableValuePairsExamples >> testArrayPairsLong [
	<gtExample>
	| limit pairs |
	limit := 3 * GtInspector indexableDisplayLimit.
	pairs := (1 to: limit) asArray gtInspectorVariableValuePairs.
	
	self assert: pairs size equals: (2 * GtInspector indexableDisplayLimit).
	
	self 
		assert: (pairs collect: [ :each | each key ]) 
		equals: ((1 to: GtInspector indexableDisplayLimit) asOrderedCollection 
			addAll: (limit - GtInspector indexableDisplayLimit + 1 to: limit) asOrderedCollection;
			yourself).
		
	^ pairs
]

{ #category : #object }
GtInspectorVariableValuePairsExamples >> testArrayPairsOverLimit [
	<gtExample>
	| limit pairs |
	
	limit := 2 * GtInspector indexableDisplayLimit + 1.
	pairs := (1 to: limit) asArray gtInspectorVariableValuePairs.
	
	self assert: pairs size equals: (2 * GtInspector indexableDisplayLimit).
	self 
		assert: (pairs collect: [:each | each key ]) 
		equals: ((1 to: GtInspector indexableDisplayLimit) asOrderedCollection 
			addAll: (limit - GtInspector indexableDisplayLimit + 1 to: limit) asOrderedCollection; 
			yourself).
	^ pairs
]

{ #category : #object }
GtInspectorVariableValuePairsExamples >> testArrayPairsSmall [
	<gtExample>
	| pairs |
	
	pairs := (1 to: 10) asArray gtInspectorVariableValuePairs.
	self assert: pairs size equals: 10.
	self assert: ((pairs collect: [ :each | each key ]) 
		allSatisfy: [ :e | (pairs at: e) = (e->e) ]).
	
	^ pairs
]

{ #category : #object }
GtInspectorVariableValuePairsExamples >> testArrayPairsUnderLimit [
	<gtExample>
	| limit pairs |
	limit := 2 * GtInspector indexableDisplayLimit - 1.
	pairs := (1 to: limit) asArray gtInspectorVariableValuePairs.
	
	self assert: pairs size equals: limit.
	self assert: ((pairs collect: [ :each | each key ]) allSatisfy: [ :e | (pairs at: e) = (e -> e) ]).
	self assert: (pairs collect: [ :each | each key ]) equals: (1 to: limit) asOrderedCollection.
	
	^ pairs
]

{ #category : #context }
GtInspectorVariableValuePairsExamples >> testContextNodes [
	<gtExample>
	| pairs x tempVariables indexVariables instVariables |
	
	x := 42.
	pairs := OrderedCollection new.
	[ :y | y+1+x ] asContext gtInspectorVariableNodesIn: pairs.	
	pairs := pairs withIndexCollect: [ :e :i | i -> e ].
	
	tempVariables := pairs select: [ :e | e value label beginsWith: '[' ].
	indexVariables := pairs select: [ :e | e value key isInteger ].
	instVariables := pairs select: [ :e | e value isKindOf: GtInspectorSlotNode ].
	
	self assert: (tempVariables sort last key) < (indexVariables first key).
	self assert: (indexVariables sort last key) < (instVariables first key).
	
	^ pairs
]

{ #category : #float }
GtInspectorVariableValuePairsExamples >> testFloatPairs [
	<gtExample>
	| pairs |
	
	pairs := 4.2 gtInspectorVariableValuePairs.
	self assert: pairs size equals: 2.
	
	self assert: pairs first equals: ('1' -> 1074842828).
	self assert: pairs second equals: ('2' -> 3435973837).
	
	^ pairs
]
