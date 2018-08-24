Class {
	#name : #GtInspectorSampleA,
	#superclass : #ProtoObject,
	#category : 'GToolkit-Inspector-Examples'
}

{ #category : #ui }
GtInspectorSampleA >> gtViewRemovedInSubclassFor: aView [
	<gtView: 0>
	^ aView explicit
		title: 'ViewRemovedInSubclass';
		stencil: [ BlElement new size: 50@50; background: Color red ]
]
