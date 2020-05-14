Class {
	#name : #GtPagerEventPassingMaximizer,
	#superclass : #GtPagerMaximizer,
	#category : #'GToolkit-Pager-Stencils and Builders'
}

{ #category : #private }
GtPagerEventPassingMaximizer >> minimizeDueTo: anEvent [
	originalParent dispatchEvent: anEvent.
	self minimize.
]

{ #category : #'instance creation' }
GtPagerEventPassingMaximizer >> newOverlayContent [
	^ super newOverlayContent
		when: GtPhlowObjectToSelect
		do: [ :anEvent | 
			originalParent dispatchEvent: anEvent ];
		when: GtPhlowObjectToSpawn
		do: [ :anEvent | 
			self minimizeDueTo: anEvent ].
]
