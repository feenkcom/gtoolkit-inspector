Class {
	#name : #GtInlineForwardViewRefactoringController,
	#superclass : #GtMethodInlineMessageFromComponentRefactoringController,
	#category : #'GToolkit-Inspector-Refactoring'
}

{ #category : #accessing }
GtInlineForwardViewRefactoringController >> implementor [
	^ implementor
		ifNil: [ implementor := self potentialImplementors
					detect: [ :each | each name ~= sourceCoderViewModel behavior name ]
					ifNone: [ self potentialImplementors anyOne ] ]
]

{ #category : #private }
GtInlineForwardViewRefactoringController >> potentialImplementors [
	^ ((GtPharoIndex current implementersOf: node literalValue)
		collect: [ :each | each methodClass ])
		asSortedCollection: [ :a :b | a name < b name ]
]

{ #category : #accessing }
GtInlineForwardViewRefactoringController >> previewPosition [
	^ node stopPosition
]

{ #category : #accessing }
GtInlineForwardViewRefactoringController >> receiverAttributePosition [
	^ node stopPosition
]

{ #category : #private }
GtInlineForwardViewRefactoringController >> refactoringClass [
	^ GtInlineForwardViewRefactoring
]
