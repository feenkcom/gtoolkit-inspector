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
	| anInspector aClass anInstance anEvents |
	anInspector := self basicInspector.
	aClass := phlowDemo demoClass.
	anInstance := aClass new.
	anInspector spawnInitial: anInstance.
	anEvents := OrderedCollection new.
	anInspector 
		when: GtInspectorObservedObjectDefinitionChangedEvent 
		do: [ :anEvent | anEvents add: anEvent ].
	"phlowDemo printOnMethodDefinition.
	self assert: anEvents size equals: 1."
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
