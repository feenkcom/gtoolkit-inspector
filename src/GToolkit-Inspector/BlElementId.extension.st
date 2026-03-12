Extension { #name : #BlElementId }

{ #category : #'*GToolkit-Inspector' }
BlElementId >> asBlocElementCode [
	"Return a string representing the element ID as a code, 
	e.g., `#'my--id' asBlocElementId indexed: 12`.
	Note: I am used for development purposes, e.g., 
	to copy a code representing the element ID 
	that can be pasted to another source code."

	<return: #String>
	^ self asSymbol printString
]
