Class {
	#name : #GtPagerPageProtoModel,
	#superclass : #BrPagerPageModel,
	#category : #'GToolkit-Pager-View Model'
}

{ #category : #accessing }
GtPagerPageProtoModel >> contentElement [
	"Return the element that represents a (wrapped) tool"
	<return: #BlElement>
	^ self subclassResponsibility
]

{ #category : #configuration }
GtPagerPageProtoModel >> pager: aPager [
	"This method is called from ${class:GtPagerModel}$ when a page is added to the pager."
]

{ #category : #configuration }
GtPagerPageProtoModel >> removePager: aPager [
	"This method is called from ${class:GtPagerModel}$ when a page is removed from the pager."
]
