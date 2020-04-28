Class {
	#name : #GtPagerPageProtoWidth,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Pager-Strategies'
}

{ #category : #testing }
GtPagerPageProtoWidth class >> isAbstract [
	^ self name = #GtPagerPageProtoWidth 
]

{ #category : #'api - embellising' }
GtPagerPageProtoWidth >> embellishPage: aPageElement [
	"Configure the page element"
	^ self subclassResponsibility
]
