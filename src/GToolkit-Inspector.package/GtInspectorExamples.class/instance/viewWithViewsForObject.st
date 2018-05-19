examples
viewWithViewsForObject
	<gtExample>
	| view element |
	view := GtPhlowView new.
	{1 . 2} gtViewsFor: view inContext: nil.
	element := view asElementDo: [ :x | x ].
	self assert: element notNil.
	self assert: (element isKindOf: BlElement).
	^ view