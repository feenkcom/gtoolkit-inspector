api - inspector
spawnDueTo: anEvent

	self
		findPageContaining: anEvent sourceElement
		ifPresent: [ :aPageElement | self spawn: anEvent object after: aPageElement ]
		ifAbsent: [ 	]