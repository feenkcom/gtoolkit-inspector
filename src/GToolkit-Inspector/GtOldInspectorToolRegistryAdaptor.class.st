Class {
	#name : #GtOldInspectorToolRegistryAdaptor,
	#superclass : #Object,
	#category : #'GToolkit-Inspector-ToolRegistry'
}

{ #category : #actions }
GtOldInspectorToolRegistryAdaptor class >> inspect: anObject [ 
	^ GtOldInspector openOn: anObject
]

{ #category : #testing }
GtOldInspectorToolRegistryAdaptor class >> isRegistered [
	<return: #Boolean>
	^ Smalltalk tools inspector = self 

]

{ #category : #'tools registry' }
GtOldInspectorToolRegistryAdaptor class >> register [
	<script>
	self registerToolsOn: Smalltalk tools
]

{ #category : #'tools registry' }
GtOldInspectorToolRegistryAdaptor class >> registerToolsOn: aToolRegistry [
	aToolRegistry register: self as: #inspector
]

{ #category : #'tools registry' }
GtOldInspectorToolRegistryAdaptor class >> unregister [
	<script>
	GTInspector register
]
