Class {
	#name : #GtPagerPageWidth,
	#superclass : #GtPagerPageProtoWidth,
	#category : #'GToolkit-Pager-Strategies'
}

{ #category : #accessing }
GtPagerPageWidth class >> exact [
	^ GtPagerPageExactWidth new
]

{ #category : #testing }
GtPagerPageWidth class >> isAbstract [
	^ self name = #GtPagerPageWidth 
]

{ #category : #accessing }
GtPagerPageWidth class >> weighted [
	^ GtPagerPageWeightedWidth new
]
