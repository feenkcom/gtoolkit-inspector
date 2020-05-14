Class {
	#name : #Gt2InspectorExamples,
	#superclass : #Object,
	#category : #'GToolkit-Inspector-! New - Examples'
}

{ #category : #'examples - inspector' }
Gt2InspectorExamples >> basicInspector [
	<gtExample>
	| anInspector |
	anInspector := self basicInspectorClass new.
	self configureInspector: anInspector.
	^ anInspector
]

{ #category : #'examples - inspector' }
Gt2InspectorExamples >> basicInspectorClass [
	<gtExample>
	^ GtInspector
]

{ #category : #'examples - object holder' }
Gt2InspectorExamples >> basicObjectHolder [
	<gtExample>
	| anInspector |
	anInspector := self basicObjectHolderClass new.
	^ anInspector
]

{ #category : #'examples - object holder' }
Gt2InspectorExamples >> basicObjectHolderClass [
	<gtExample>
	^ GtInspectorObject
]

{ #category : #configuration }
Gt2InspectorExamples >> configureInspector: anInspector [
	<gtExample>
	anInspector look: BrShadowLook.
	anInspector background: Color white.
	anInspector
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ]
]

{ #category : #'examples - inspected objects' }
Gt2InspectorExamples >> inspectedObject [
	<gtExample>
	^ self inspectedObjectClass new 
]

{ #category : #'examples - inspected objects' }
Gt2InspectorExamples >> inspectedObjectClass [
	<gtExample>
	^ Gt2InspectorExampleObject
]

{ #category : #'examples - inspector in pager' }
Gt2InspectorExamples >> inspectorInPagerWithExampleObject [
	<gtExample>
	| aPager anObject |
	anObject := self inspectedObject.
	aPager := self basicInspectorClass createOn: anObject.
	self assert: aPager pages size equals: 1.
	^ aPager
]

{ #category : #'examples - inspector' }
Gt2InspectorExamples >> inspectorWithExampleObject [
	<gtExample>
	| anInspector anObject |
	anInspector := self basicInspector.
	anObject := self inspectedObject.
	anInspector object: anObject.
	self assert: anInspector model objectHolder object equals: anObject.
	^ anInspector
]

{ #category : #'examples - object holder' }
Gt2InspectorExamples >> objectHolderWithExampleObject [
	<gtExample>
	| aModel anObject |
	aModel := self basicObjectHolder.
	anObject := self inspectedObject.
	aModel object: anObject.
	self assert: aModel object equals: anObject.
	^ aModel
]
