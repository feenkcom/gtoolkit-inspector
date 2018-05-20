examples
viewsOfSampleSubclassOfA
	<gtExample>
	| views elements |
	views := GtInspectorSampleSubclassOfA new gtViewsInContext: nil.
	self assert: (views size = 1).
	elements := OrderedCollection new.
	views collect: [ :eachView | eachView asElementDo: [ :el | elements add: el ] ].
	self assert: elements isEmpty.
	^ views