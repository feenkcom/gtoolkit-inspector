Trait {
	#name : #TGtInspectorObjectAccess,
	#instVars : [
		'objectHolder'
	],
	#category : 'GToolkit-Inspector-Model'
}

{ #category : #defaults }
TGtInspectorObjectAccess >> defaultObjectHolder [
	^ GtInspectorObject null
]

{ #category : #initialization }
TGtInspectorObjectAccess >> initializeObjectHolder [
	objectHolder := self defaultObjectHolder
]

{ #category : #'api - accessing' }
TGtInspectorObjectAccess >> object [
	^ self objectHolder object
]

{ #category : #'api - accessing' }
TGtInspectorObjectAccess >> object: anObject [
	| anObjectHolder |
	anObjectHolder := GtInspectorObject new object: anObject.
	self objectHolder: anObjectHolder.
]

{ #category : #'api - accessing' }
TGtInspectorObjectAccess >> objectHolder [
	<return: #GtInspectorObject>
	^ objectHolder
]

{ #category : #'api - accessing' }
TGtInspectorObjectAccess >> objectHolder: anObjectHolder [
	self 
		assert: [ anObjectHolder isNotNil ]
		description: [ 'Object holder must be non-nil' ].
	objectHolder = anObjectHolder ifTrue: [ ^ self ].
	objectHolder := anObjectHolder.
	self onObjectHolderChanged.
]

{ #category : #'hooks - object' }
TGtInspectorObjectAccess >> onObjectHolderChanged [
	"Classes can handle object holder changes"
]
