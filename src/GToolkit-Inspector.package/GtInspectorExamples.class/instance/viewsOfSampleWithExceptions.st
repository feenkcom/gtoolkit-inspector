examples
viewsOfSampleWithExceptions
	<gtExample>
	| views elements |
	views := GtInspectorSampleWithExceptionsInExtensions new gtViewsInContext: nil.
	self assert: (views size = 2).
	elements := OrderedCollection new.
	views collect: [ :eachView | eachView asElementDo: [ :el | elements add: el ] ].
	self assert: elements size = 2.
	^ views