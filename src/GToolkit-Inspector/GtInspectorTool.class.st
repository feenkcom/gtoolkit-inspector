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

{ #category : #converting }
GtInspectorTool >> asElementDo: aOneArgBlock [
	"Create a tool element and execute the block"
	| anInspector |
	anInspector := GtInspector new 
		objectHolder: self objectHolder.
	anInspector
		addEventHandler: (GtPhlowToolChangedObjectHandler new
			onChangeSend: #object: to: anInspector).
	^ aOneArgBlock cull: anInspector.
]

{ #category : #'api - converting' }
GtInspectorTool >> asTabDo: aBlock [
	| aTab |
	aTab := BrTab new
		look: BrGlamorousTabSwitcherWithIconLook;
		label: self name;
		icon: BrGlamorousVectorIcons inspect;
		stencil: [ self asElementDo: [ :anElement | anElement ] ].
	aBlock cull: aTab.
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
