Trait {
	#name : #TGtContentElementAccessors,
	#instVars : [
		'contentElement'
	],
	#traits : 'TGtElementAssertion',
	#classTraits : 'TGtElementAssertion classTrait',
	#category : #'GToolkit-Pager-Traits'
}

{ #category : #accessing }
TGtContentElementAccessors >> contentElement [
	^ contentElement
]

{ #category : #accessing }
TGtContentElementAccessors >> contentElement: anElement [
	self assertElement: anElement.
	contentElement := anElement
]
