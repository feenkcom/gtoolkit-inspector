Class {
	#name : #GtPagerPageEvent,
	#superclass : #BlEvent,
	#instVars : [
		'pager',
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

{ #category : #accessing }
GtPagerPageEvent >> pager [
	^ pager
]

{ #category : #accessing }
GtPagerPageEvent >> pager: anObject [
	pager := anObject
]
