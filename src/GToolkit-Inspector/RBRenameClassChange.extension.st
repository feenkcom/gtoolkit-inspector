Extension { #name : #RBRenameClassChange }

{ #category : #'*GToolkit-Inspector' }
RBRenameClassChange >> gtLabel [
	| aText |
	aText := 'Rename ' asRopedText foreground: Color gray.
	aText append: self oldName asString asRopedText.
	aText append: (' to ' asRopedText foreground: Color gray).
	aText append: self newName asString asRopedText.
	^ aText
]
