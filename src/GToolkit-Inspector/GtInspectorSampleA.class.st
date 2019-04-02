Class {
	#name : #GtInspectorSampleA,
	#superclass : #ProtoObject,
	#category : 'GToolkit-Inspector-Examples'
}

{ #category : #ui }
GtInspectorSampleA >> gtViewRemovedInSubclassFor: aView [
	<gtView>
	^ aView explicit
		title: 'ViewRemovedInSubclass';
		priority: 50;
		stencil: [ BlElement new size: 50@50; background: Color red ]
]
