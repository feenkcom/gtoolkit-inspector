Extension { #name : #BrSelectionChanged }

{ #category : #'*GToolkit-Inspector' }
BrSelectionChanged >> acceptInspectorHandler: aHandler [
	^ aHandler selectionChangedEvent: self
]
