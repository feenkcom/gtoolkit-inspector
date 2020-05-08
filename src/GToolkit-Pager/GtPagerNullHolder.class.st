Class {
	#name : #GtPagerNullHolder,
	#superclass : #GtPagerProtoHolder,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit-Pager-Strategies'
}

{ #category : #'api - actions' }
GtPagerNullHolder >> close: aPageElement [
	"do nothing"
]

{ #category : #testing }
GtPagerNullHolder >> isFirstPageEqualTo: aPageElement [
	^ false
]

{ #category : #testing }
GtPagerNullHolder >> isLastPageEqualTo: aPageElement [
	^ false
]

{ #category : #'api - actions' }
GtPagerNullHolder >> maximizeIn: aCreationContext [
	"do nothing"
]

{ #category : #'api - actions' }
GtPagerNullHolder >> select: aGtPagerPageSelectionContext [
	"do nothing"
]

{ #category : #'api - actions' }
GtPagerNullHolder >> smoothScrollToLast [
	"do nothing"
]

{ #category : #'api - actions' }
GtPagerNullHolder >> spawn: aGtPagerPageSelectionContext [
	"do nothing"
]

{ #category : #'announcer - subscription' }
GtPagerNullHolder >> when: anEvent do: aBlock [
	"Do nothing"
]
