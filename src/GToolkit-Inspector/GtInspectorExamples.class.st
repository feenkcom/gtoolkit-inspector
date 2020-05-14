Class {
	#name : #GtInspectorExamples,
	#superclass : #Object,
	#category : #'GToolkit-Inspector-Examples'
}

{ #category : #'examples - inspector' }
GtInspectorExamples >> basicInspector [
	<gtExample>
	| anInspector |
	anInspector := self basicInspectorClass new.
	self configureInspector: anInspector.
	^ anInspector
]

{ #category : #'examples - inspector' }
GtInspectorExamples >> basicInspectorClass [
	<gtExample>
	^ GtInspector
]

{ #category : #'examples - object holder' }
GtInspectorExamples >> basicObjectHolder [
	<gtExample>
	| anInspector |
	anInspector := self basicObjectHolderClass new.
	^ anInspector
]

{ #category : #'examples - object holder' }
GtInspectorExamples >> basicObjectHolderClass [
	<gtExample>
	^ GtInspectorObject
]

{ #category : #configuration }
GtInspectorExamples >> configureInspector: anInspector [
	<gtExample>
	anInspector look: BrShadowLook.
	anInspector background: Color white.
	anInspector
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ]
]

{ #category : #'examples - inspected objects' }
GtInspectorExamples >> inspectedObject [
	<gtExample>
	^ self inspectedObjectClass new 
]

{ #category : #'examples - inspected objects' }
GtInspectorExamples >> inspectedObjectClass [
	<gtExample>
	^ GtInspectorExampleObject
]

{ #category : #'examples - inspector in pager' }
GtInspectorExamples >> inspectorInPagerWithExampleObject [
	<gtExample>
	| aPager anObject |
	anObject := self inspectedObject.
	aPager := self basicInspectorClass createOn: anObject.
	self assert: aPager pages size equals: 1.
	^ aPager
]

{ #category : #'examples - inspector' }
GtInspectorExamples >> inspectorWithExampleObject [
	<gtExample>
	| anInspector anObject |
	anInspector := self basicInspector.
	anObject := self inspectedObject.
	anInspector object: anObject.
	self assert: anInspector model objectHolder object equals: anObject.
	^ anInspector
]

{ #category : #'examples - object holder' }
GtInspectorExamples >> objectHolderWithExampleObject [
	<gtExample>
	| aModel anObject |
	aModel := self basicObjectHolder.
	anObject := self inspectedObject.
	aModel object: anObject.
	self assert: aModel object equals: anObject.
	^ aModel
]
