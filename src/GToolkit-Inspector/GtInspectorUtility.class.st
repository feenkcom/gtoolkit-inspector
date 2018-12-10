Class {
	#name : #GtInspectorUtility,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Inspector-Utility'
}

{ #category : #'accessing - ui' }
GtInspectorUtility class >> compositeViewElementInPagerPageModel: aBrPagerPageModel [
	"Return a composite view element that was constructed using GtPhlowCompositeView."
	<return: #BrTabGroup>
	| aBrTabGroup |
	aBrTabGroup := aBrPagerPageModel widget phlow 
		firstChildWithCompositeViewDo: [ :anElement | anElement ].
	self 
		assert: [ aBrTabGroup notNil ] 
		description: [ 'Element with composite view was not found' ].
	^ aBrTabGroup
]
