Class {
	#name : #GtInspectorSampleB,
	#superclass : #Object,
	#category : #'GToolkit-Inspector-Example Samples'
}

{ #category : #'gt - extensions' }
GtInspectorSampleB >> gtOneFor: aView [
	<gtView>
	^ aView forward
		title: 'One';
		priority: 1;
		object: [ 
			GtInspectorSampleBOneForwardObjectSignal emit.
			self ];
		view: #gtTwoFor:
]

{ #category : #'gt - extensions' }
GtInspectorSampleB >> gtTwoFor: aView [
	<gtView>
	^ aView list
		title: 'Two';
		priority: 2;
		items: [ 72 to: 144 ]
]
