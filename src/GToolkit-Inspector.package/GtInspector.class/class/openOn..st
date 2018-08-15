instance creation
openOn: anObject
	| anInspector aSpace |

	anInspector := self new.
	anInspector constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	anInspector spawn: Object.

	aSpace := BlSpace new.
	aSpace title: 'Inspector'.
	aSpace extent: 1200@600.
	aSpace root addChild: anInspector.
	aSpace show