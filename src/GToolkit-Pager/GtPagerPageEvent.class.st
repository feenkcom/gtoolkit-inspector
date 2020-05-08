Class {
	#name : #GtPagerPageEvent,
	#superclass : #BlEvent,
	#traits : 'TGtPagerAccessors',
	#classTraits : 'TGtPagerAccessors classTrait',
	#instVars : [
		'page'
	],
	#category : #'GToolkit-Pager-Events'
}

{ #category : #accessing }
GtPagerPageEvent >> page [
	^ page
]

{ #category : #accessing }
GtPagerPageEvent >> page: anObject [
	page := anObject
]
