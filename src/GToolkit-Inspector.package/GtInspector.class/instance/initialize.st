initialization
initialize
	super initialize.

	pager := BrPager new.
	pager constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	self addChild: pager.

	self when: GtPhlowObjectToSpawn do: [ :anEvent | self spawnDueTo: anEvent ]