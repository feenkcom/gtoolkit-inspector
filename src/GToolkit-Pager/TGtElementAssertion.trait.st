Trait {
	#name : #TGtElementAssertion,
	#category : #'GToolkit-Pager-Traits'
}

{ #category : #asserting }
TGtElementAssertion >> assertElement: anElement [
	self 
		assert: [ anElement isNotNil ]
		description: [ 'Content element must be non-nil' ].
	self 
		assert: [ anElement isKindOf: BlElement ]
		description: [ 'Content element must be kind of ', BlElement name ].
]
