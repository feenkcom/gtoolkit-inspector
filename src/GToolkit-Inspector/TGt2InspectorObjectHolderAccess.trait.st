Trait {
	#name : #TGt2InspectorObjectHolderAccess,
	#instVars : [
		'objectHolder'
	],
	#category : #'GToolkit-Inspector-! New - Traits'
}

{ #category : #defaults }
TGt2InspectorObjectHolderAccess >> defaultObjectHolder [
	^ Gt2InspectorObjectHolder null
]

{ #category : #initialization }
TGt2InspectorObjectHolderAccess >> initializeObjectHolder [
	objectHolder := self defaultObjectHolder
]

{ #category : #notifying }
TGt2InspectorObjectHolderAccess >> notifyObjectHolderChanged [
	"Classes can perform specific actions"
]

{ #category : #accessing }
TGt2InspectorObjectHolderAccess >> objectHolder [
	<return: #Gt2InspectorObjectHolder>
	^ objectHolder
]

{ #category : #accessing }
TGt2InspectorObjectHolderAccess >> objectHolder: anObjectHolder [
	self 
		assert: [ anObjectHolder isNotNil ]
		description: [ 'Object holder must be non-nil' ].
	objectHolder = anObjectHolder ifTrue: [ ^ self ].
	objectHolder := anObjectHolder.
	self notifyObjectHolderChanged.
]
