initialization
initialize
	super initialize.

	pager := BrPager new.
	pager constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	self addChild: pager.

	self when: GtInspectorObjectToSpawn do: [ :anEvent | self spawnDueTo: anEvent ]