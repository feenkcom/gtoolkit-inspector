Class {
	#name : 'GtInspectorViewsExamples',
	#superclass : 'Object',
	#category : 'GToolkit-Inspector-Examples'
}

{ #category : 'examples - exceptions' }
GtInspectorViewsExamples >> containerViewOfSampleWithExceptions [
	<gtExample>
	| view object |
	object := GtInspectorSampleWithExceptionsInExtensions new.
	view := object gtViewsFor: GtPhlowView empty.
	view asElementDo: [ :x | self assert: x notNil ].
	^ object
]

{ #category : 'examples - exceptions' }
GtInspectorViewsExamples >> exceptionAtCreation [
	<gtExample>
	| aView |
	aView := GtPhlowView empty 
		on: GtInspectorSampleWithExceptionsInExtensions new
		perform: #gtViewWithExceptionAtCreationFor:.
	self assert: aView notNil.
	self 
		assert: aView definingMethod 
		equals: (GtInspectorSampleWithExceptionsInExtensions 
			>> #gtViewWithExceptionAtCreationFor:) asRingDefinition.
	^ aView
]

{ #category : 'examples - working' }
GtInspectorViewsExamples >> labelViewOfMyself [
	<gtExample>
	| labelView |
	labelView := self gtViewsFor: GtPhlowEmptyView new.
	self assert: labelView newLabel asString equals: self gtDisplayString.
	^ labelView 
]

{ #category : 'examples - working' }
GtInspectorViewsExamples >> labelViewOfSmallInteger [
	<gtExample>
	| labelView |
	labelView := 42 gtViewsFor: GtPhlowEmptyView new.
	self assert: labelView newLabel asString = 'a SmallInteger (42)'.
	^ labelView 
]

{ #category : 'examples - exceptions' }
GtInspectorViewsExamples >> sampleWithExceptions [
	<gtExample>
	^ GtInspectorSampleWithExceptionsInExtensions new
]

{ #category : 'examples - exceptions' }
GtInspectorViewsExamples >> viewNotReturning [
	<gtExample>
	| aView anObject anElement |
	anObject := GtInspectorSampleNotReturningTheView new.
	aView := anObject gtViewsFor: GtPhlowView empty.
	aView asElementDo: [ :theElement | anElement := theElement ].
	self assert: anElement isNotNil.
	^ anObject
]

{ #category : 'examples - working' }
GtInspectorViewsExamples >> viewWithViewsForCollection [
	<gtExample>
	| aView anElement |
	aView := { 1 . 2 } gtViewsFor: GtPhlowView empty.
	anElement := aView asElementDo: [ :x | x ].
	self assert: anElement notNil.
	self assert: (anElement isKindOf: BlElement).
	^ aView
]

{ #category : 'examples - working' }
GtInspectorViewsExamples >> viewsOfSampleA [
	<gtExample>
	| theViews theElements |
	theViews := GtInspectorSampleA new gtViewsInContext: GtPhlowContext null.
	self assert: theViews size equals: 1.
	theElements := OrderedCollection new.
	theViews do: [ :eachView | eachView asElementDo: [ :el | theElements add: el ] ].
	self assert: theElements size equals: 1.
	^ theViews
]

{ #category : 'examples - working' }
GtInspectorViewsExamples >> viewsOfSampleSubclassOfA [
	<gtExample>
	| theViews theElements |
	theViews := GtInspectorSampleSubclassOfA new gtViewsInContext: GtPhlowContext null.
	self assert: theViews size equals: 1.
	theElements := OrderedCollection new.
	theViews do: [ :eachView | eachView asElementDo: [ :el | theElements add: el ] ].
	self assert: theElements size equals: 1.
	^ theViews
]

{ #category : 'examples - exceptions' }
GtInspectorViewsExamples >> viewsOfSampleWithExceptions [
	<gtExample>
	| allViews elements viewsNotDefinedInObject |
	allViews := GtInspectorSampleWithExceptionsInExtensions new gtViewsInContext: GtPhlowContext null.
	viewsNotDefinedInObject := allViews select: [ :each | each definingMethod methodClass ~= ProtoObject and: [ each definingMethod methodClass ~= Object ] ].
	self assert: viewsNotDefinedInObject size equals: 2.
	elements := OrderedCollection new.
	viewsNotDefinedInObject collect: [ :eachView | eachView asElementDo: [ :el | elements add: el ] ].
	self assert: elements size equals: viewsNotDefinedInObject size.
	^ viewsNotDefinedInObject
]
