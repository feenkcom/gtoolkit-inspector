initialize-release
defaultView
	^ BlElement new
		constraintsDo: [ :constraints |
			constraints horizontal matchParent.
			constraints vertical matchParent.
			constraints padding: (BlInsets all: 10) ];
		background: (BlBackground paint: Color white)