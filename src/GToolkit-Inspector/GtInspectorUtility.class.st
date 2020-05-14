Class {
	#name : #GtInspectorUtility,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Inspector-Utility'
}

{ #category : #ui }
GtInspectorUtility class >> compositeViewElementIn: anElement [
	"Return a composite view element that was constructed using GtPhlowCompositeView."
	<return: #BrTabGroup or: nil>
	anElement phlow 
		firstChildWithCompositeViewDo: [ :aBrTabGroup | ^ aBrTabGroup ].
	^ nil
]

{ #category : #ui }
GtInspectorUtility class >> compositeViewElementInPagerPageModel: aBrPagerPageModel [
	"Return a composite view element that was constructed using GtPhlowCompositeView."
	<return: #BrTabGroup or: nil>
	| aBrTabGroup |
	aBrTabGroup := aBrPagerPageModel widget phlow 
		firstChildWithCompositeViewDo: [ :anElement | anElement ].
	^ aBrTabGroup 
]

{ #category : #phlow }
GtInspectorUtility class >> detectPhlowIndex: aGtPhlowView byPriorityIn: aGtPhlowViews [
	<return: #Integer>
	^ aGtPhlowViews 
		detectIndex: [ :existingView | 
			self hasPhlowView: existingView higherPriorityThen: aGtPhlowView ]
		ifNone: [ aGtPhlowViews size + 1 ].
]

{ #category : #phlow }
GtInspectorUtility class >> hasPhlowView: aGtPhlowViewOne higherPriorityThen: aGtPhlowViewTwo [
	<return: #Boolean>
	^ [ aGtPhlowViewOne priority > aGtPhlowViewTwo priority ] 
		on: Error do: [ :anException | anException return: false ]
]
