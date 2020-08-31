"
I am an abstract class.
I provide basic ${class:TBrLayoutResizable}$ methods.
See my ${class:GtInspectorElement|expanded|show=#gtSubclassesFor:}$ for concrete implementations:
"
Class {
	#name : #GtInspectorElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#category : #'GToolkit-Inspector-UI'
}

{ #category : #initialization }
GtInspectorElement >> initialize [
	super initialize.
	self addInteractiveModelState: BrLayoutHorizontalResizerModel matchParent.
	self addInteractiveModelState: BrLayoutVerticalResizerModel matchParent.
]
