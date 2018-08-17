instance creation
openOn: anObject
	| anInspector aSpace |

	anInspector := self new.
	anInspector constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	anInspector spawn: anObject.

	aSpace := BlSpace new.
	aSpace title: 'Inspector'.
	aSpace extent: 1200@600.
	aSpace root addChild: anInspector.
	"aSpace root when: BlDblClickEvent do: [ :evt | BlElementSelection on: evt target ]."
	aSpace show.
	
	^ anInspector