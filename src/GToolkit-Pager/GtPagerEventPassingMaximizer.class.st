Class {
	#name : #GtPagerEventPassingMaximizer,
	#superclass : #GtPagerMaximizer,
	#instVars : [
		'originalParent'
	],
	#category : #'GToolkit-Pager-Stencils and Builders'
}

{ #category : #'host space - displaying' }
GtPagerEventPassingMaximizer >> maximize [
	originalParent := self contentElement parent.
	super maximize.
]

{ #category : #'instance creation' }
GtPagerEventPassingMaximizer >> newOverlayContent [
	^ super newOverlayContent
		when: GtPhlowObjectToSelect
		do: [ :anEvent | 
			originalParent dispatchEvent: anEvent copy ];
		when: GtPhlowObjectToSpawn
		do: [ :anEvent | 
			originalParent dispatchEvent: anEvent copy ].
]
