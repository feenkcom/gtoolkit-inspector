Class {
	#name : #GtInspectorToolRegistryAdaptor,
	#superclass : #Object,
	#category : #'GToolkit-Inspector-Tool Registry'
}

{ #category : #actions }
GtInspectorToolRegistryAdaptor class >> inspect: anObject [
	| pager newSpace |
	newSpace := BlSpace new
			inPager: anObject gtDefaultInspectorTool;
			title: anObject gtInspectorTitleString;
			show.
	pager := newSpace root childAt: 1.

	^ pager
]

{ #category : #testing }
GtInspectorToolRegistryAdaptor class >> isRegistered [
	<return: #Boolean>
	^ Smalltalk tools inspector = self 

]

{ #category : #actions }
GtInspectorToolRegistryAdaptor class >> openOn: anObject [ 
	^ self inspect: anObject 
]

{ #category : #'tools registry' }
GtInspectorToolRegistryAdaptor class >> register [
	<script>
	self registerToolsOn: Smalltalk tools
]

{ #category : #'tools registry' }
GtInspectorToolRegistryAdaptor class >> registerToolsOn: aToolRegistry [
	aToolRegistry register: self as: #inspector
]

{ #category : #'tools registry' }
GtInspectorToolRegistryAdaptor class >> unregister [
	<script>
	StInspector register
]
