Class {
	#name : #GtInspectorTool,
	#superclass : #GtPhlowTool,
	#traits : 'TGtInspectorObjectAccess',
	#classTraits : 'TGtInspectorObjectAccess classTrait',
	#category : #'GToolkit-Inspector-Phlow Tool'
}

{ #category : #'instance creation' }
GtInspectorTool class >> forObject: anObject [
	^ self new object: anObject
]

{ #category : #'instance creation' }
GtInspectorTool class >> forObject: anObject viewSelector: aSymbol [
	^ self new object: anObject viewSelector: aSymbol
]

{ #category : #accessing }
GtInspectorTool class >> priority [
	<return: #Number>
	^ 1
]

{ #category : #'api - converting' }
GtInspectorTool >> asElementDo: aOneArgBlock [
	"Create a tool element and execute the block"
	| anInspector |
	anInspector := GtInspector new 
		objectHolder: self objectHolder.
	^ aOneArgBlock cull: anInspector cull: self.
]

{ #category : #'private - converting' }
GtInspectorTool >> asTabElement [
	"Return a tool element that is going to be used as a part of ${class:GtPhlowCompositeTool}$"
	<return: #BlElement>
	| anInspector |
	anInspector := super asTabElement.
	anInspector addEventHandler: (GtPhlowToolChangedObjectHandler new
		onChangeSend: #object: to: anInspector).
	^ anInspector
]

{ #category : #'api - accessing' }
GtInspectorTool >> icon [
	^ BrGlamorousVectorIcons inspect
]

{ #category : #initialization }
GtInspectorTool >> initialize [
	super initialize.
	self initializeObjectHolder.
]

{ #category : #'api - accessing' }
GtInspectorTool >> name [
	^ 'inspector'
]

{ #category : #'api - accessing' }
GtInspectorTool >> object [
	"compatibility method for ${GLMBlocObjectToSelect}$"
	^ self objectHolder object
]

{ #category : #'api - accessing' }
GtInspectorTool >> object: anObject [
	"Store object that is going to be inspected"
	| anObjectHolder |
	anObjectHolder := GtInspectorObject new object: anObject.
	self objectHolder: anObjectHolder.
]

{ #category : #'api - accessing' }
GtInspectorTool >> object: anObject viewSelector: aSymbol [
	"Store object that is going to be inspected and displayed using a specific Phlow view message selector"
	| anObjectHolder |
	anObjectHolder := GtInspectorObject new object: anObject; viewSelector: aSymbol.
	self objectHolder: anObjectHolder.
]

{ #category : #'private - accessing' }
GtInspectorTool >> tabLook [
	^ BrGlamorousTabSwitcherWithIconAptitude
]
