"
I am an abstract class.
I provide basic {{gtMethod:GtInspectorObjectElement>>#objectHolder|label=object holder}} accessors.
See my {{gtClass:GtInspectorObjectElement|expanded|show=#gtSubclassesFor:}} for concrete implementations:


"
Class {
	#name : 'GtInspectorObjectElement',
	#superclass : 'GtInspectorElement',
	#instVars : [
		'objectHolder'
	],
	#category : 'GToolkit-Inspector-UI'
}

{ #category : 'defaults' }
GtInspectorObjectElement >> defaultObjectHolder [
	^ GtInspectorObject null
]

{ #category : 'initialization' }
GtInspectorObjectElement >> initialize [
	super initialize.
	objectHolder := self defaultObjectHolder.
]

{ #category : 'api - accessing' }
GtInspectorObjectElement >> object [
	^ self objectHolder object
]

{ #category : 'api - accessing' }
GtInspectorObjectElement >> object: anObject [
	| anObjectHolder |
	anObjectHolder := GtInspectorObject new object: anObject.
	self objectHolder: anObjectHolder.
]

{ #category : 'api - accessing' }
GtInspectorObjectElement >> objectHolder [
	<return: #GtInspectorObject>
	^ objectHolder
]

{ #category : 'api - accessing' }
GtInspectorObjectElement >> objectHolder: anObjectHolder [
	self 
		assert: [ anObjectHolder isNotNil ]
		description: [ 'Object holder must be non-nil' ].
	objectHolder = anObjectHolder ifTrue: [ ^ self ].
	objectHolder := anObjectHolder.
	self onObjectHolderChanged.
]

{ #category : 'private - hooks' }
GtInspectorObjectElement >> onObjectHolderChanged [
	"Classes can handle object holder changes"
]
