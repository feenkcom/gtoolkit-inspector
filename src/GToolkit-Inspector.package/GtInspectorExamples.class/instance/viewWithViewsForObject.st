examples
viewWithViewsForObject
	<gtExample>
	| view element |
	view := GtPhlowExplicitView new.
	{1 . 2} gtViewsFor: view.
	element := view asElementDo: [ :x | x ].
	self assert: element notNil.
	self assert: (element isKindOf: BlElement).
	^ view