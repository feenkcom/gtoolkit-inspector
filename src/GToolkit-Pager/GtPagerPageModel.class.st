Class {
	#name : #GtPagerPageModel,
	#superclass : #BrPagerPageModel,
	#category : #'GToolkit-Pager-View Model'
}

{ #category : #defaults }
GtPagerPageModel >> defaultEmbellisher [
	^ GtPagerPageEmbellisher new
]

{ #category : #configuration }
GtPagerPageModel >> pager: aPager [
	self embellisher pager: aPager.
]

{ #category : #configuration }
GtPagerPageModel >> removePager: aPager [
	self embellisher removePager: aPager.
]
