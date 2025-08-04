Class {
	#name : #GtInspectorSampleA,
	#superclass : #ProtoObject,
	#category : #'GToolkit-Inspector-Example Samples'
}

{ #category : #ui }
GtInspectorSampleA >> gtViewRemovedInSubclassFor: aView [
	<gtView>
	^ aView explicit
		title: 'ViewRemovedInSubclass';
		priority: 50;
		stencil: [ BlElement new size: 50@50; background: Color red ]
]
