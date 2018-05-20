examples
viewsOfSampleA
	<gtExample>
	| views elements |
	views := GtInspectorSampleA new gtViewsInContext: nil.
	self assert: (views size = 1).
	elements := OrderedCollection new.
	views collect: [ :eachView | eachView asElementDo: [ :el | elements add: el ] ].
	self assert: elements size = 1.
	^ views