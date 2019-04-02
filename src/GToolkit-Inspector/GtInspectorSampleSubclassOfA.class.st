Class {
	#name : #GtInspectorSampleSubclassOfA,
	#superclass : #GtInspectorSampleA,
	#category : 'GToolkit-Inspector-Examples'
}

{ #category : #ui }
GtInspectorSampleSubclassOfA >> gtViewRemovedInSubclassFor: aView [
	^ aView empty
]
