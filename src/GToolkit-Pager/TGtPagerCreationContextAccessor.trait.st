Trait {
	#name : #TGtPagerCreationContextAccessor,
	#instVars : [
		'creationContext'
	],
	#category : #'GToolkit-Pager-Contexts'
}

{ #category : #accessing }
TGtPagerCreationContextAccessor >> creationContext [
	<return: #GtPagerPageCreationContext>
	^ creationContext
]

{ #category : #accessing }
TGtPagerCreationContextAccessor >> creationContext: aGtPagerPageCreationContext [
	self 
		assert: [ aGtPagerPageCreationContext isNotNil ] 
		description: [ 'Creation context must be non-nil' ].
	creationContext := aGtPagerPageCreationContext
]
