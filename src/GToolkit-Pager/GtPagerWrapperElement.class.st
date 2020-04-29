Class {
	#name : #GtPagerWrapperElement,
	#superclass : #BlElement,
	#category : #'GToolkit-Pager-UI'
}

{ #category : #accessing }
GtPagerWrapperElement >> tool [
	<return: #BlElement>
	^ self childAt: 1
]
