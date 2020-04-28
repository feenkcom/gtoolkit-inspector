Class {
	#name : #GtPagerPageSelectionContext,
	#superclass : #GtPagerPageProtoSelectionContext,
	#traits : 'TGtPhlowToolAccessors',
	#classTraits : 'TGtPhlowToolAccessors classTrait',
	#instVars : [
		'object',
		'afterPage'
	],
	#category : #'GToolkit-Pager-Contexts'
}

{ #category : #factory }
GtPagerPageSelectionContext class >> null [
	^ GtPagerPageNullSelectionContext default
]

{ #category : #accessing }
GtPagerPageSelectionContext >> afterPage [
	<return: #BlElement>
	^ afterPage
]

{ #category : #accessing }
GtPagerPageSelectionContext >> afterPage: anElement [
	self 
		assert: [ anElement isNotNil ] 
		description: [ 'Page element must be non-nil' ].
	afterPage := anElement
]

{ #category : #initialization }
GtPagerPageSelectionContext >> initialize [
	super initialize.
	self initializeTool.
]

{ #category : #accessing }
GtPagerPageSelectionContext >> object [
	^ object
]

{ #category : #accessing }
GtPagerPageSelectionContext >> object: anObject [
	object := anObject
]
