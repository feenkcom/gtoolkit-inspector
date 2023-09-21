Class {
	#name : #GtInspectorTool,
	#superclass : #GtPhlowTool,
	#traits : 'TGtInspectorObjectAccess',
	#classTraits : 'TGtInspectorObjectAccess classTrait',
	#instVars : [
		'tabLook',
		'name',
		'playgroundPageStrategy',
		'databasesRegistry',
		'externalSnippetContext'
	],
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

{ #category : #'instance creation' }
GtInspectorTool class >> openWrappedOn: anObject title: aString from: sourceElement [
	"Open the supplied object as a tab in GtWorld with the supplied title"

	GtPager
		openWrappedOn: (self forObject: anObject) asElement
		title: aString
		from: sourceElement
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
	
	anInspector := GtInspector new.
	
	"We first configure the inspector before setting up the holder,
	as when the holder is updated the inspector updates its state."
	playgroundPageStrategy ifNotNil: [ :aPlaygroundPageStrategy |
		anInspector playgroundPageStrategy: aPlaygroundPageStrategy ].
	databasesRegistry ifNotNil: [ :aRegistry |
		anInspector databasesRegistry: aRegistry ].
	externalSnippetContext ifNotNil: [ :aRegistry |
		anInspector externalSnippetContext: aRegistry ].
		
	anInspector objectHolder: self objectHolder.
	
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
GtInspectorTool >> databasesRegistry: aDatabasesRegistry [
	databasesRegistry := aDatabasesRegistry
]

{ #category : #accessing }
GtInspectorTool >> defaultName [
	^ 'inspector'
]

{ #category : #'private - accessing' }
GtInspectorTool >> defaultTabLook [
	^ BrGlamorousTabSwitcherWithIconAptitude
]

{ #category : #'api - accessing' }
GtInspectorTool >> externalSnippetContext: anExternalSnippetContext [
	externalSnippetContext := anExternalSnippetContext
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
	^ name ifNil: [
		self defaultName ]
]

{ #category : #'api - accessing' }
GtInspectorTool >> name: aName [
	name := aName
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
	anObjectHolder := GtInspectorObject new 
		object: anObject; 
		viewSelector: aSymbol.
	self objectHolder: anObjectHolder.
]

{ #category : #'api - accessing' }
GtInspectorTool >> playgroundPageStrategy: aPlaygroundPageStrategy [
	playgroundPageStrategy := aPlaygroundPageStrategy
]

{ #category : #'private - accessing' }
GtInspectorTool >> tabLook [
	^  tabLook ifNil: [
		self defaultTabLook ]
]

{ #category : #'api - accessing' }
GtInspectorTool >> valuable: aValuable [
	"Store a valuable that will be later computed 
	to obtain an object that is going to be inspected"
	| anObjectHolder |
	anObjectHolder := GtInspectorValuableObject new valuable: aValuable.
	self objectHolder: anObjectHolder.
]

{ #category : #accessing }
GtInspectorTool >> withLabelAndIconAptitude [
	tabLook := BrGlamorousTabSwitcherWithLabelAndIconAptitude
]
