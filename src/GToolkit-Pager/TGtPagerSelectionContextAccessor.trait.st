Trait {
	#name : #TGtPagerSelectionContextAccessor,
	#instVars : [
		'selectionContext'
	],
	#category : #'GToolkit-Pager-Contexts'
}

{ #category : #defaults }
TGtPagerSelectionContextAccessor >> defaultSelectionContext [
	^ GtPagerPageSelectionContext null
]

{ #category : #initialization }
TGtPagerSelectionContextAccessor >> initializeSelectionContext [
	selectionContext := self defaultSelectionContext.
]

{ #category : #accessing }
TGtPagerSelectionContextAccessor >> selectionContext [
	<return: #GtPagerPageSelectionContext>
	^ selectionContext
]

{ #category : #accessing }
TGtPagerSelectionContextAccessor >> selectionContext: aGtPagerPageSelectionContext [
	self 
		assert: [ aGtPagerPageSelectionContext isNotNil ] 
		description: [ 'Selection context must be non-nil' ].
	selectionContext := aGtPagerPageSelectionContext
]
