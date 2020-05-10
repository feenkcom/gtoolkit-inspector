Class {
	#name : #GtPagerPageCreationContext,
	#superclass : #GtPagerPageProtoCreationContext,
	#traits : 'TGtContentElementAccessors',
	#classTraits : 'TGtContentElementAccessors classTrait',
	#instVars : [
		'embellisher',
		'pageElement',
		'wrapperElement'
	],
	#category : #'GToolkit-Pager-Contexts'
}

{ #category : #factory }
GtPagerPageCreationContext class >> null [ 
	^ GtPagerPageNullCreationContext default
]

{ #category : #accessing }
GtPagerPageCreationContext >> embellisher [
	<return: #GtPagerPageEmbellisher>
	^ embellisher
]

{ #category : #accessing }
GtPagerPageCreationContext >> embellisher: aGtPagerPageEmbellisher [
	self 
		assert: [ aGtPagerPageEmbellisher isNotNil ] 
		description: [ 'Embellisher must be non-nil' ].
	embellisher := aGtPagerPageEmbellisher
]

{ #category : #requests }
GtPagerPageCreationContext >> maximizePageContentInPager: aGtPager [
	"maximize a page"
	aGtPager maximizePageContentIn: self contentElement
]

{ #category : #convenience }
GtPagerPageCreationContext >> model [
	^ self contentElement viewModel model
]

{ #category : #accessing }
GtPagerPageCreationContext >> pageElement [
	^ pageElement
]

{ #category : #accessing }
GtPagerPageCreationContext >> pageElement: anElement [
	self assertElement: anElement.
	pageElement := anElement.
]

{ #category : #accessing }
GtPagerPageCreationContext >> wrapperElement [
	^ wrapperElement
]

{ #category : #accessing }
GtPagerPageCreationContext >> wrapperElement: anElement [
	self assertElement: anElement.
	wrapperElement := anElement
]
