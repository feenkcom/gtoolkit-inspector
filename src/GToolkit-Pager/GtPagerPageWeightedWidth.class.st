Class {
	#name : #GtPagerPageWeightedWidth,
	#superclass : #GtPagerPageWidth,
	#instVars : [
		'weight'
	],
	#category : #'GToolkit-Pager-Strategies'
}

{ #category : #defaults }
GtPagerPageWeightedWidth >> defaultWeight [
	^ 0.5
]

{ #category : #'api - embellising' }
GtPagerPageWeightedWidth >> embellishPage: aPageElement [
	"Configure the page element"
	aPageElement
		weight: self weight;
		constraintsDo: [ :c | c horizontal matchParent ].
]

{ #category : #initialization }
GtPagerPageWeightedWidth >> initialize [
	super initialize.
	weight := self defaultWeight.
]

{ #category : #printing }
GtPagerPageWeightedWidth >> printOn: aStream [ 
	aStream nextPutAll: 'Weighted width: '; print: self weight
]

{ #category : #accessing }
GtPagerPageWeightedWidth >> weight [
	^ weight
]

{ #category : #accessing }
GtPagerPageWeightedWidth >> weight: anObject [
	weight := anObject
]
