Class {
	#name : 'GtInspectorToolRegistryAdaptor',
	#superclass : 'Object',
	#category : 'GToolkit-Inspector-Tool Registry'
}

{ #category : 'actions' }
GtInspectorToolRegistryAdaptor class >> inspect: anObject [ 
	^ (GtInspector openOn: anObject) maximized
]

{ #category : 'testing' }
GtInspectorToolRegistryAdaptor class >> isRegistered [
	<return: #Boolean>
	^ Smalltalk tools inspector = self 

]

{ #category : 'tools registry' }
GtInspectorToolRegistryAdaptor class >> register [
	<script>
	self registerToolsOn: Smalltalk tools
]

{ #category : 'tools registry' }
GtInspectorToolRegistryAdaptor class >> registerToolsOn: aToolRegistry [
	aToolRegistry register: self as: #inspector
]

{ #category : 'tools registry' }
GtInspectorToolRegistryAdaptor class >> unregister [
	<script>
	GTInspector register
]
