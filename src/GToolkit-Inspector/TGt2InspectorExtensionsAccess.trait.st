Trait {
	#name : #TGt2InspectorExtensionsAccess,
	#instVars : [
		'extensions'
	],
	#category : #'GToolkit-Inspector-! New - Model'
}

{ #category : #asserting }
TGt2InspectorExtensionsAccess >> assertExtensions: anExtensions [
	self 
		assert: [ anExtensions isNotNil ]
		description: [ 'Inspector extensions must be non-nil' ].
]

{ #category : #defaults }
TGt2InspectorExtensionsAccess >> defaultExtensions [
	^ Gt2InspectorExtensions default
]

{ #category : #accessing }
TGt2InspectorExtensionsAccess >> extensions [
	<return: #Gt2InspectorProtoModelExtensions>
	^ extensions
]

{ #category : #accessing }
TGt2InspectorExtensionsAccess >> extensions: anExtensions [
	self assertExtensions: anExtensions.
	extensions := anExtensions
]

{ #category : #initialization }
TGt2InspectorExtensionsAccess >> initializeExtensions [
	extensions := self defaultExtensions.
]
