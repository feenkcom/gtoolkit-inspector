as yet unclassified
defaultNode: aNode
	| text textElement |
	text := BlRopedText string: ((aNode class printString) truncateTo:30).
	textElement := BlTextElement new.
	textElement text: text.
	^ textElement 