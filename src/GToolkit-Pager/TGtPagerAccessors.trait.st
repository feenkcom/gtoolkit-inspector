Trait {
	#name : #TGtPagerAccessors,
	#instVars : [
		'pager'
	],
	#category : #'GToolkit-Pager-Traits'
}

{ #category : #accessing }
TGtPagerAccessors >> pager [
	<return: #GtPager>
	^ pager
]

{ #category : #accessing }
TGtPagerAccessors >> pager: aGtPager [
	self 
		assert: [ aGtPager isNotNil ]
		description: [ 'Toolpager must be non-nil' ].
	pager := aGtPager
]
