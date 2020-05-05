Class {
	#name : #GtPagerPageCreationContext,
	#superclass : #GtPagerPageProtoCreationContext,
	#traits : 'TGtContentElementAccessors',
	#classTraits : 'TGtContentElementAccessors classTrait',
	#instVars : [
		'pageElement',
		'wrapperElement'
	],
	#category : #'GToolkit-Pager-Contexts'
}

{ #category : #factory }
GtPagerPageCreationContext class >> null [ 
	^ GtPagerPageNullCreationContext default
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
