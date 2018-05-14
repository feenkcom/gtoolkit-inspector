examples
viewsElementForElement
	<gtExample>
	| tabGroup |
	tabGroup := (BlElement new
		size: 1000@1000;
		background: Color red) gtViewsElementInContext: nil.
	self assert: (tabGroup isKindOf: BlElement).
	^ tabGroup.