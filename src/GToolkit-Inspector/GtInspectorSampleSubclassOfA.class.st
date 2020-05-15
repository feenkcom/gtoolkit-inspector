Class {
	#name : #GtInspectorSampleSubclassOfA,
	#superclass : #GtInspectorSampleA,
	#category : #'GToolkit-Inspector-Example Samples'
}

{ #category : #ui }
GtInspectorSampleSubclassOfA >> gtViewRemovedInSubclassFor: aView [
	^ aView empty
]
