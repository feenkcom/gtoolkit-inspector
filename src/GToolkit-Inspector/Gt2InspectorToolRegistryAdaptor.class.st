Class {
	#name : #Gt2InspectorToolRegistryAdaptor,
	#superclass : #Object,
	#category : #'GToolkit-Inspector-! New - Tool Registry'
}

{ #category : #actions }
Gt2InspectorToolRegistryAdaptor class >> inspect: anObject [ 
	^ (GtInspector openOn: anObject) maximized
]

{ #category : #testing }
Gt2InspectorToolRegistryAdaptor class >> isRegistered [
	<return: #Boolean>
	^ Smalltalk tools inspector = self 

]

{ #category : #'tools registry' }
Gt2InspectorToolRegistryAdaptor class >> register [
	<script>
	self registerToolsOn: Smalltalk tools
]

{ #category : #'tools registry' }
Gt2InspectorToolRegistryAdaptor class >> registerToolsOn: aToolRegistry [
	aToolRegistry register: self as: #inspector
]

{ #category : #'tools registry' }
Gt2InspectorToolRegistryAdaptor class >> unregister [
	<script>
	GTInspector register
]
