examples
containerViewOfSampleWithExceptions
	<gtExample>
	| view object |
	object := GtInspectorSampleWithExceptionsInExtensions new.
	view := object gtViewsFor: GtPhlowExplicitView new.
	view asElementDo: [ :x | self assert: x notNil ].
	^ object