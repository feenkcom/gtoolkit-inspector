Trait {
	#name : #TGtPagerHolderAccessors,
	#instVars : [
		'pagerHolder'
	],
	#category : #'GToolkit-Pager-Strategies'
}

{ #category : #defaults }
TGtPagerHolderAccessors >> defaultPagerHolder [
	^ GtPagerHolder null
]

{ #category : #initialization }
TGtPagerHolderAccessors >> initializePagerHolder [
	pagerHolder := self defaultPagerHolder.
]

{ #category : #accessing }
TGtPagerHolderAccessors >> pagerHolder [
	<return: #GtPagerHolder>
	^ pagerHolder
]

{ #category : #accessing }
TGtPagerHolderAccessors >> pagerHolder: aGtPagerHolder [
	self 
		assert: [ aGtPagerHolder isNotNil ]
		description: [ 'Pager holder must be non-nil' ].
	^ pagerHolder
]
