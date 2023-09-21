"
I am an abstract class.
I provide basic {{gtClass:TBrLayoutResizable}} methods.
See my {{gtClass:GtInspectorElement|expanded|show=#gtSubclassesFor:}} for concrete implementations:


"
Class {
	#name : #GtInspectorElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#category : 'GToolkit-Inspector-UI'
}

{ #category : #initialization }
GtInspectorElement >> initialize [
	super initialize.
	
	self matchParent
]
