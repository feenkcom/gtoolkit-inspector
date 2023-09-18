Extension { #name : #RBRefactoryChange }

{ #category : #'*GToolkit-Inspector' }
RBRefactoryChange >> gtChildren [
	^ #()
]

{ #category : #'*GToolkit-Inspector' }
RBRefactoryChange >> gtDescription [
	^self gtLabel
]

{ #category : #'*GToolkit-Inspector' }
RBRefactoryChange >> gtInspectorLabel [
	| label |
	label := BrLabel new.
	label
		text: self displayString;
		aptitude: BrGlamorousLabelAptitude;
		layout: BlLinearLayout vertical alignCenter;
		padding: (BlInsets all: 10).
	^ label
]

{ #category : #'*GToolkit-Inspector' }
RBRefactoryChange >> gtLabel [
	^ self name asRopedText
]
