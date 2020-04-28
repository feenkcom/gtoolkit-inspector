Class {
	#name : #GtPagerProtoHolder,
	#superclass : #Object,
	#category : #'GToolkit-Pager-Strategies'
}

{ #category : #'api - actions' }
GtPagerProtoHolder >> close: aPageElement [
	"Close/remove a page from a pager"
	self subclassResponsibility
]

{ #category : #testing }
GtPagerProtoHolder >> isFirstPageEqualTo: aPageElement [
	<return: #Boolean>
	^ self subclassResponsibility
]

{ #category : #testing }
GtPagerProtoHolder >> isLastPageEqualTo: aPageElement [
	<return: #Boolean>
	^ self subclassResponsibility
]

{ #category : #'api - actions' }
GtPagerProtoHolder >> maximizePageContent: aContentElement [
	"maximize a page"
	self subclassResponsibility
]

{ #category : #'api - actions' }
GtPagerProtoHolder >> select: aGtPagerPageSelectionContext [
	"Select a new page in a pager"
	self subclassResponsibility
]

{ #category : #'api - actions' }
GtPagerProtoHolder >> smoothScrollToLast [
	"Scroll to the last page"
	self subclassResponsibility
]

{ #category : #'api - actions' }
GtPagerProtoHolder >> spawn: aGtPagerPageSelectionContext [
	"Spawn a new page in a pager"
	self subclassResponsibility
]

{ #category : #'announcer - subscription' }
GtPagerProtoHolder >> when: anEvent do: aBlock [
	"Register an event handler"
	^ self subclassResponsibility
]
