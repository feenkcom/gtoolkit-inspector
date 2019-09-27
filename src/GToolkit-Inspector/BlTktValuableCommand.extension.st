Extension { #name : #BlTktValuableCommand }

{ #category : #'*GToolkit-Inspector' }
BlTktValuableCommand >> gtBlockClosureFor: aView [
	<gtView>
	^ self valuable
		ifNil: [ aView empty ] 
		ifNotNil: [ :aValuable | aValuable gtSourceCodeFor: aView ]
]
