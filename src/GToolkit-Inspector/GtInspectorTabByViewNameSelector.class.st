Class {
	#name : #GtInspectorTabByViewNameSelector,
	#superclass : #GtInspectorTabSelector,
	#traits : 'TGtInspectorTabNameAccessor',
	#classTraits : 'TGtInspectorTabNameAccessor classTrait',
	#category : #'GToolkit-Inspector-Tab Selector'
}

{ #category : #initialization }
GtInspectorTabByViewNameSelector >> initialize [
	super initialize.
	
	self initializeTabName.
]

{ #category : #actions }
GtInspectorTabByViewNameSelector >> matchesTab: aTabModel [ 
	^ self tabName matchesTab: aTabModel
]

{ #category : #printing }
GtInspectorTabByViewNameSelector >> printOn: aStream [
	aStream 
		nextPutAll: 'Selector of: ';
		print: self tabName
]
