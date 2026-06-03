Class {
	#name : #GtRemoteInspectorTool,
	#superclass : #GtInspectorTool,
	#category : #'GToolkit-Inspector-Phlow Tool'
}

{ #category : #accessing }
GtRemoteInspectorTool >> configureInspectorElement: anInspector [
	super configureInspectorElement: anInspector.
	
	anInspector explicitIcon: self icon
]
