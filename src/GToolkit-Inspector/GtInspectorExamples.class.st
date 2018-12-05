Class {
	#name : #GtInspectorExamples,
	#superclass : #Object,
	#category : 'GToolkit-Inspector-Examples'
}

{ #category : #examples }
GtInspectorExamples >> viewWithViewsForObject [
	<gtExample>
	| view element |
	view := {1 . 2} gtViewsFor: GtPhlowView empty.
	element := view asElementDo: [ :x | x ].
	self assert: element notNil.
	self assert: (element isKindOf: BlElement).
	^ view
]

{ #category : #examples }
GtInspectorExamples >> viewsOfSampleA [
	<gtExample>
	| views elements |
	views := GtInspectorSampleA new gtViewsInContext: nil.
	self assert: views size equals: 1.
	elements := OrderedCollection new.
	views do: [ :eachView | eachView asElementDo: [ :el | elements add: el ] ].
	self assert: elements size equals: 1.
	^ views
]

{ #category : #examples }
GtInspectorExamples >> viewsOfSampleSubclassOfA [
	<gtExample>
	| views elements |
	views := GtInspectorSampleSubclassOfA new gtViewsInContext: nil.
	self assert: views size equals: 1.
	elements := OrderedCollection new.
	views do: [ :eachView | eachView asElementDo: [ :el | elements add: el ] ].
	self assert: elements isEmpty.
	^ views
]
