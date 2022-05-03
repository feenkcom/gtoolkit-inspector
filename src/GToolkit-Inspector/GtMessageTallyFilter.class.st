Class {
	#name : #GtMessageTallyFilter,
	#superclass : #Object,
	#category : #'GToolkit-Inspector-Message Tallies'
}

{ #category : #examples }
GtMessageTallyFilter class >> messageTallyForGather [
	<gtExample>
	
	^ MessageTally
		tallySendsTo: nil
		inBlock:
			[ [ #a:b: numArgs ] value.
			[ #c:d:e: numArgs ] value ]
		showTree: false
		closeAfter: false
		openResultWindow: false
]

{ #category : #examples }
GtMessageTallyFilter class >> messageTallyForInjectInto [
	<gtExample>
	
	^ MessageTally
		tallySendsTo: nil
		inBlock: [ (1 to: 10) inject: 0 into: [ :sum :each | sum + each ] ]
		showTree: false
		closeAfter: false
		openResultWindow: false
]

{ #category : #examples }
GtMessageTallyFilter class >> messageTallyForRecursion [
	<gtExample>
	
	^ MessageTally
		tallySendsTo: nil
		inBlock: [ 10 slowFactorial ]
		showTree: false
		closeAfter: false
		openResultWindow: false
]

{ #category : #filtering }
GtMessageTallyFilter >> filter: aMessageTally [
	^ self subclassResponsibility
]
