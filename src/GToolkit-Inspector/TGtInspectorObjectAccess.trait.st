Trait {
	#name : #TGtInspectorObjectAccess,
	#instVars : [
		'objectHolder'
	],
	#category : #'GToolkit-Inspector-Model'
}

{ #category : #defaults }
TGtInspectorObjectAccess >> defaultObjectHolder [
	^ GtInspectorObject null
]

{ #category : #initialization }
TGtInspectorObjectAccess >> initializeObjectHolder [
	objectHolder := self defaultObjectHolder
]

{ #category : #accessing }
TGtInspectorObjectAccess >> objectHolder [
	<return: #GtInspectorObject>
	^ objectHolder
]

{ #category : #accessing }
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
