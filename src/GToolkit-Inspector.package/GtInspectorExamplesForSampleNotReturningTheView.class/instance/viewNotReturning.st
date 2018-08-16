examples
viewNotReturning
	<gtExample>
	| view object |
	object := GtInspectorSampleNotReturningTheView new.
	view := object gtViewsFor: GtPhlowExplicitView new.
	view asElementDo: [ :element | self assert: element notNil ].
	^ object