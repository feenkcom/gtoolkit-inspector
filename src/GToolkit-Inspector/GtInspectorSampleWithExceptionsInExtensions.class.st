"
GtInspector openOn: self new


"
Class {
	#name : #GtInspectorSampleWithExceptionsInExtensions,
	#superclass : #Object,
	#category : #'GToolkit-Inspector-Example Samples'
}

{ #category : #ui }
GtInspectorSampleWithExceptionsInExtensions >> gtDisplayOn: stream [
	self error: 'Some exception'
]

{ #category : #ui }
GtInspectorSampleWithExceptionsInExtensions >> gtViewWithExceptionAtCreationFor: aView [
	<gtView>
	1/0.
	^ aView title: 'With error during view creation'
]

{ #category : #ui }
GtInspectorSampleWithExceptionsInExtensions >> gtViewWithExceptionInStencilFor: aView [
	<gtView>
	^ aView explicit
		title: 'With error in stencil';
		priority: 50;
		stencil: [ 
			1/0.
			BlElement new ]
]
