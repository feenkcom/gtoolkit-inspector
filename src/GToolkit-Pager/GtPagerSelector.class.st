Class {
	#name : #GtPagerSelector,
	#superclass : #GtPagerProtoSelector,
	#instVars : [
		'pager'
	],
	#category : #'GToolkit-Pager-Strategies'
}

{ #category : #accessing }
GtPagerSelector >> pager [
	<return: #GtPager>
	^ pager
]

{ #category : #accessing }
GtPagerSelector >> pager: aGtPager [
	self 
		assert: [ aGtPager isNotNil ] 
		description: [ 'Pager must be non-nil' ].
	pager := aGtPager
]

{ #category : #'api - scrolling' }
GtPagerSelector >> select: aSelectedObject with: aPhlowTool after: aPageElement [
	(self pager hasPageAfter: aPageElement) ifTrue: [
		self spawn: aSelectedObject with: aPhlowTool after: aPageElement ]
]
