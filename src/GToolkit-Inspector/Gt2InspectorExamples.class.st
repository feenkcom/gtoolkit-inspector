Class {
	#name : #Gt2InspectorExamples,
	#superclass : #Object,
	#category : #'GToolkit-Inspector-! New - Examples'
}

{ #category : #'examples - ui without look' }
Gt2InspectorExamples >> basicInspector [
	<gtExample>
	| anInspector |
	anInspector := self basicInspectorClass new.
	self configureInspector: anInspector.
	^ anInspector
]

{ #category : #'examples - ui without look' }
Gt2InspectorExamples >> basicInspectorClass [
	<gtExample>
	^ Gt2Inspector
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
	^ Gt2InspectorObjectHolder
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

{ #category : #'examples - ui' }
Gt2InspectorExamples >> defaultInspector [
	<gtExample>
	| anInspector |
	anInspector := self basicInspectorClass default.
	self configureInspector: anInspector.
	^ anInspector
]

{ #category : #'examples - ui' }
Gt2InspectorExamples >> defaultInspectorWithExampleObject [
	<gtExample>
	| anInspector aModel |
	anInspector := self defaultInspector.
	aModel := self objectHolderWithExampleObject.
	anInspector viewModel objectHolder: aModel.
	self assert: anInspector viewModel objectHolder equals: aModel.
	^ anInspector
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

{ #category : #'examples - ui without look' }
Gt2InspectorExamples >> inspectorWithExampleObject [
	<gtExample>
	| anInspector aModel |
	anInspector := self basicInspector.
	aModel := self objectHolderWithExampleObject.
	anInspector viewModel objectHolder: aModel.
	self assert: anInspector viewModel objectHolder equals: aModel.
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
