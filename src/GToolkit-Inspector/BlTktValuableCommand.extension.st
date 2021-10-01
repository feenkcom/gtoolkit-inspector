Extension { #name : #BlTktValuableCommand }

{ #category : #'*GToolkit-Inspector' }
BlTktValuableCommand >> gtBlockClosureFor: aView [
	<gtView>
	^ self valuable
		ifNil: [ aView empty ] 
		ifNotNil: [ :aValuable |
			aValuable isClosure
				ifTrue: [ aValuable gtSourceCodeFor: aView ]
				ifFalse: [ aView empty ] ]
]
