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

{ #category : #'api - actions' }
GtPagerProtoHolder >> maximizePageContent: aContentElement [
	"maximize a page"
	self subclassResponsibility
]
