Class {
	#name : 'GtInspectorExamples',
	#superclass : 'Object',
	#category : 'GToolkit-Inspector-Examples'
}

{ #category : 'examples - ui - content' }
GtInspectorExamples >> basicContentElement [
	<gtExample>
	| anElement |
	anElement := GtInspectorContentElement new.
	anElement matchParent.
	self assert: anElement objectHolder equals: GtInspectorObject null.
	^ anElement
]

{ #category : 'examples - inspector' }
GtInspectorExamples >> basicInspector [
	<gtExample>
	| anInspector |
	anInspector := self basicInspectorClass new.
	self configureInspector: anInspector.
	^ anInspector
]

{ #category : 'examples - inspector' }
GtInspectorExamples >> basicInspectorClass [
	<gtExample>
	^ GtInspector
]

{ #category : 'examples - ui - tool' }
GtInspectorExamples >> basicInspectorElement [
	<gtExample>
	| anElement |
	anElement := GtInspector new.
	anElement matchParent.
	self assert: anElement objectHolder equals: GtInspectorObject null.
	^ anElement
]

{ #category : 'examples - object holder' }
GtInspectorExamples >> basicObjectHolder [
	<gtExample>
	| anInspector |
	anInspector := self basicObjectHolderClass new.
	^ anInspector
]

{ #category : 'examples - object holder' }
GtInspectorExamples >> basicObjectHolderClass [
	<gtExample>
	^ GtInspectorObject
]

{ #category : 'examples - ui - playground' }
GtInspectorExamples >> basicPlaygroundElement [
	<gtExample>
	| anElement |
	anElement := (self class environment at: GtInspector embeddedPlaygroundName) new.
	anElement matchParent.
	self assert: anElement objectHolder equals: GtInspectorObject null.
	^ anElement
]

{ #category : 'configuration' }
GtInspectorExamples >> configureInspector: anInspector [
	<gtExample>
	anInspector aptitude: BrShadowAptitude.
	anInspector background: Color white.
	anInspector
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ]
]

{ #category : 'examples - ui - content' }
GtInspectorExamples >> contentElement [
	<gtExample>
	| anElement |
	anElement := self basicContentElement.
	anElement object: 42.
	self assert: anElement object equals: 42.
	^ anElement
]

{ #category : 'examples - inspected objects' }
GtInspectorExamples >> inspectedObject [
	<gtExample>
	^ self inspectedObjectClass new 
]

{ #category : 'examples - inspected objects' }
GtInspectorExamples >> inspectedObjectClass [
	<gtExample>
	^ GtInspectorExampleObject
]

{ #category : 'examples - ui - tool' }
GtInspectorExamples >> inspectorElement [
	<gtExample>
	| anElement |
	anElement := self basicInspectorElement.
	anElement object: 42.
	self assert: anElement object equals: 42.
	^ anElement
]

{ #category : 'examples - inspector in pager' }
GtInspectorExamples >> inspectorInPagerWithExampleObject [
	<gtExample>
	| aPager anObject |
	anObject := self inspectedObject.
	aPager := self basicInspectorClass createOn: anObject.
	self assert: aPager pages size equals: 1.
	^ aPager
]

{ #category : 'examples - inspector' }
GtInspectorExamples >> inspectorWithExampleObject [
	<gtExample>
	| anInspector anObject |
	anInspector := self basicInspector.
	anObject := self inspectedObject.
	anInspector object: anObject.
	self assert: anInspector objectHolder object equals: anObject.
	^ anInspector
]

{ #category : 'examples - object holder' }
GtInspectorExamples >> objectHolderWithExampleObject [
	<gtExample>
	| aModel anObject |
	aModel := self basicObjectHolder.
	anObject := self inspectedObject.
	aModel object: anObject.
	self assert: aModel object equals: anObject.
	^ aModel
]

{ #category : 'examples - ui - playground' }
GtInspectorExamples >> playgroundElement [
	<gtExample>
	| anElement |
	anElement := self basicPlaygroundElement.
	anElement object: 42.
	self assert: anElement object equals: 42.
	self assert: anElement playPage receiver equals: 42.
	^ anElement
]
