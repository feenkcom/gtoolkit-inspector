Class {
	#name : #GtActionCreatorExamples,
	#superclass : #Object,
	#category : #'GToolkit-Inspector-Examples'
}

{ #category : #'as yet unclassified' }
GtActionCreatorExamples >> createActionExample [
	<gtExample>
	| creator pattern |
	creator := GtActionCreator
			actionCreatorForSource: 'self primeFactors'
			in: Integer.
	pattern := RBPatternParser
			parseMethod: 'gtPrimeFactorsFor: `var <gtAction> ^`var button icon: `@icon; tooltip: `@tooltip; action: [:button | button phlow spawnObject: self primeFactors]'.
	self
		assert: (pattern match: (RBParser parseMethod: creator source) inContext: Dictionary new).

	^ creator
]
