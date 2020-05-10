Class {
	#name : #GtPagerHolder,
	#superclass : #GtPagerProtoHolder,
	#traits : 'TGtPagerAccessors',
	#classTraits : 'TGtPagerAccessors classTrait',
	#category : #'GToolkit-Pager-Strategies'
}

{ #category : #factory }
GtPagerHolder class >> null [
	^ GtPagerNullHolder default
]

{ #category : #'api - actions' }
GtPagerHolder >> close: aPageElement [
	"Close/remove a page from a pager"
	self pager removePage: aPageElement.
]

{ #category : #'api - actions' }
GtPagerHolder >> isFirstPageEqualTo: aPageElement [
	<return: #Boolean>
	^ aPageElement viewModel = self pager pages first
]

{ #category : #'api - actions' }
GtPagerHolder >> isLastPageEqualTo: aPageElement [
	<return: #Boolean>
	^ aPageElement viewModel = self pager pages last
]

{ #category : #'api - actions' }
GtPagerHolder >> maximizeIn: aCreationContext [
	aCreationContext maximizePageContentInPager: self pager
]

{ #category : #'api - actions' }
GtPagerHolder >> select: aGtPagerPageSelectionContext [
	"Select a new page in a pager"
	self pager select: aGtPagerPageSelectionContext
]

{ #category : #'api - actions' }
GtPagerHolder >> smoothScrollToLast [
	"Scroll to the last page"
]

{ #category : #'api - actions' }
GtPagerHolder >> spawn: aGtPagerPageSelectionContext [
	"Spawn a new page in a pager"
	self pager spawn: aGtPagerPageSelectionContext
]

{ #category : #'announcer - subscription' }
GtPagerHolder >> when: anEvent do: aBlock [
	"Register an event handler"
	self pager when: anEvent do: aBlock
]
