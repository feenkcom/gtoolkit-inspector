instance creation
openOnPlayBook: aPlayBook
	| anInspector aSpace |

	anInspector := self new.
	anInspector constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	anInspector addPageWithContent: aPlayBook asElement for: aPlayBook.

	aSpace := BlSpace new.
	aSpace withHalos.
	aSpace title: 'Playground'.
	aSpace extent: 1200@600.
	aSpace root addChild: anInspector.
	aSpace show.
	
	^ anInspector