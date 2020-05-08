Trait {
	#name : #TGtElementAccessor,
	#instVars : [
		'element'
	],
	#category : #'GToolkit-Pager-Contexts'
}

{ #category : #accessing }
TGtElementAccessor >> element [
	<return: #BlElement>
	^ element
]

{ #category : #accessing }
TGtElementAccessor >> element: anElement [
	self 
		assert: [ anElement isNotNil ]
		description: [ 'Element must be non-nil' ].
	element := anElement
]
