visiting
visitNode: aNode withParentElement: parentElement
	| currentElement |
	currentElement := self nodeFor: aNode.
	currentElement userData at: #model put: aNode.
	currentElement graph beNode.
	allElementNodes add: (currentElement).
	
	parentElement isNotNil ifTrue: [ 
		allEdges add: (self edgeFrom: parentElement to: currentElement).
	].
	
	aNode children do: [ :c | 
		self visitNode: c withParentElement: currentElement.
	].
