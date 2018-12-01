"
!Dealing with errors in custom views

Inspecting the following snippet produces an inspector in which two views have an exception:
- one has an excpetion during the creation of the view, and 
- one has an exception in the stencil that creates the actual element to be displayed.

In both cases, the inspector offers a clean way to investigate the error: 

[[[
GtInspectorSampleWithExceptionsInExtensions new
]]]

!Inspecting exceptions

And if we are at it, you can also get an exception as a graphical element that lets you debug the exception:

[[[
[ 1/0 ] on: Error do: [ :e | e asDebuggableElement ]
]]]

"
Class {
	#name : #GtInspectorExamplesForSampleWithExceptions,
	#superclass : #Object,
	#category : 'GToolkit-Inspector-Examples'
}

{ #category : #examples }
GtInspectorExamplesForSampleWithExceptions >> containerViewOfSampleWithExceptions [
	<gtExample>
	| view object |
	object := GtInspectorSampleWithExceptionsInExtensions new.
	view := object gtViewsFor: GtPhlowView empty.
	view asElementDo: [ :x | self assert: x notNil ].
	^ object
]

{ #category : #examples }
GtInspectorExamplesForSampleWithExceptions >> sampleWithExceptions [
	<gtExample>
	^ GtInspectorSampleWithExceptionsInExtensions new
]

{ #category : #examples }
GtInspectorExamplesForSampleWithExceptions >> viewsOfSampleWithExceptions [
	<gtExample>
	| allViews elements viewsNotDefinedInObject |
	allViews := GtInspectorSampleWithExceptionsInExtensions new gtViewsInContext: nil.
	viewsNotDefinedInObject := allViews select: [ :each | each definingMethod methodClass ~= ProtoObject and: [ each definingMethod methodClass ~= Object ] ].
	self assert: viewsNotDefinedInObject size = 2.
	elements := OrderedCollection new.
	viewsNotDefinedInObject collect: [ :eachView | eachView asElementDo: [ :el | elements add: el ] ].
	self assert: elements size = viewsNotDefinedInObject size.
	^ viewsNotDefinedInObject
]
