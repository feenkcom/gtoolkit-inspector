Extension { #name : #BrSelectionDoubleClicked }

{ #category : #'*GToolkit-Inspector' }
BrSelectionDoubleClicked >> acceptInspectorHandler: aHandler [
	^ aHandler selectionDoubleClickedEvent: self
]
