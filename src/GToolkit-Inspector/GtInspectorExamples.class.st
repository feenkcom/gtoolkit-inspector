Class {
	#name : #GtInspectorExamples,
	#superclass : #Object,
	#instVars : [
		'phlowDemo'
	],
	#category : #'GToolkit-Inspector-Examples'
}

{ #category : #updating }
GtInspectorExamples >> basicInspector [
	<gtExample>
	| anInspector |
	anInspector := GtInspector new.
	anInspector constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	^ anInspector
]

{ #category : #updating }
GtInspectorExamples >> changePrintOnMethod [
	<gtExample>
	| anInspector aClass anInstance aFirstPageContentElement aSecondPageContentElement aSpace aTask |
	phlowDemo ensurePrintOnMethodRemoved.
	anInspector := self basicInspector.
	aClass := phlowDemo demoSubClass.
	anInstance := aClass new.
	anInspector spawnInitial: anInstance.
	aFirstPageContentElement := anInspector pager pages first widget childNamed: anInspector contentIdentificator.
	self assert: anInspector taskQueue tasks size equals: 0.
	"System change that should reflected in the Inspector"
	phlowDemo printOnMethodDefinition.
	aSecondPageContentElement := anInspector pager pages first widget childNamed: anInspector contentIdentificator.
	"There is a change ready to do."
	self assert: anInspector taskQueue tasks size equals: 1.
	"The updated is not done yet. It will happen when the Inspector appears in a Space"
	self assert: aFirstPageContentElement equals: aSecondPageContentElement.
	
	"Let's reinforce the changes"
	aTask := anInspector taskQueue tasks first.
	aTask action value.
	aSecondPageContentElement := anInspector pager pages first widget childNamed: anInspector contentIdentificator.
	self assert: aFirstPageContentElement ~= aSecondPageContentElement.
	"And let's remove the task"
	anInspector dequeueTask: aTask.
	self assert: anInspector taskQueue tasks size equals: 0.
	
	^ anInspector
]

{ #category : #initialization }
GtInspectorExamples >> initialize [
	super initialize.
	phlowDemo := GtPhlowDemoDefinitionsExamples new.
]

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
