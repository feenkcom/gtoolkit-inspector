Class {
	#name : #GtPagerEventPassingMaximizer,
	#superclass : #GtPagerMaximizer,
	#category : #'GToolkit-Pager-Stencils and Builders'
}

{ #category : #'instance creation' }
GtPagerEventPassingMaximizer >> newOverlayContent [
	^ super newOverlayContent
		when: GtPhlowObjectToSelect
		do: [ :anEvent | 
			originalParent dispatchEvent: anEvent copy ];
		when: GtPhlowObjectToSpawn
		do: [ :anEvent | 
			originalParent dispatchEvent: anEvent copy.
			self minimize. ].
]
