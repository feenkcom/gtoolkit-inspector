examples
containerViewOfSampleWithExceptions
	<gtExample>
	| view object |
	view := GtPhlowExplicitView new.
	object := GtInspectorSampleWithExceptionsInExtensions new.
	object gtViewsFor: view inContext: nil.
	view asElementDo: [ :x | self assert: x notNil ].
	^ object