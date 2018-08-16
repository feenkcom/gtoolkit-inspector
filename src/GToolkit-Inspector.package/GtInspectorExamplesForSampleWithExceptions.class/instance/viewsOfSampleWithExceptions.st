examples
viewsOfSampleWithExceptions
	<gtExample>
	| views elements |
	views := GtInspectorSampleWithExceptionsInExtensions new gtViewsInContext: nil.
	self assert: views size = 4.
	elements := OrderedCollection new.
	views collect: [ :eachView | eachView asElementDo: [ :el | elements add: el ] ].
	self assert: elements size = views size.
	^ views